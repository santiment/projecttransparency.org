{ config, pkgs, ... }:
  let
    fcgiSocket = "/run/phpfpm/nginx";
    user = "web";
    group = "web";
    rootFolder = "/vagrant";
  in  
  {

    #imports = [ <nixpkgs/nixos/modules/virtualisation/amazon-image.nix> ];
    #ec2.hvm = true;
    
    environment.systemPackages = with pkgs; [
      git
      apacheHttpd
      phpPackages.composer
    ];

    networking.firewall.enable = false;
    #networking.firewall.allowedTCPPorts = [22 80 443 ];
    #networking.firewall.allowedUDPPorts = [22 80 443 ];
    users.extraUsers."${user}" = {
      isNormalUser = true;
      useDefaultShell = true;
      uid = 1000;
      group = "${group}";
      home = "${rootFolder}";
      createHome = true;
    };

    users.extraGroups."${group}".gid = 1000;

    services.phpfpm.poolConfigs.nginx = ''
      listen = ${fcgiSocket}
      listen.owner = ${user}
      listen.group = ${group}
      listen.mode = 0660
      user = ${user}
      pm = ondemand
      pm.max_children = 2
      catch_workers_output = true
    '';
    

    services.nginx = {
      enable = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      user = user;
      group = group;

      commonHttpConfig = ''
        index index.php index.html index.htm;
      '';


      virtualHosts = {
        "projecttransparency.org" = {
          default = true;
          root = "${rootFolder}/public";

  	locations."~ ^.+\.php(/|$)".extraConfig = ''
	  fastcgi_pass php_projtrans_fcgi;
	  fastcgi_split_path_info ^(.+\.php)(/.*)$;
	  include ${pkgs.nginx}/conf/fastcgi_params;
	  fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	  fastcgi_param DOCUMENT_ROOT $document_root;
	  fastcgi_param QUERY_STRING $query_string;
	'';


	};
      };

      appendHttpConfig = ''
        upstream php_projtrans_fcgi {
          server unix:${fcgiSocket};
        }

        index index.php index.html index.htm;

      '';

    };

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql96;
      enableTCPIP = true;

      authentication = ''
       # "local" is for Unix domain socket connections only
       local   all             all                                     trust
       # IPv4 local connections:
       host    all             all             127.0.0.1/32            trust
       # IPv6 local connections:
       host    all             all             ::1/128                 trust
       # Allow replication connections from localhost, by a user with the
       # replication privilege.
       #local   replication     postgres                                trust
       #host    replication     postgres        127.0.0.1/32            trust
       #host    replication     postgres        ::1/128                 trust
       # Allow all connections from all users
       host all all all trust
      '';

      initialScript = ./pginit.sql;
      
    };


    systemd.timers.autodeploy = {
      enable = false; #For production
      description = "Autodeploy timer";

      wantedBy = ["multi-user.target"];
      after = [ "network.target" "local-fs.target" "remote-fs.target" ];
      timerConfig = {
        OnBootSec = 60;
	OnUnitActiveSec = 300; # Check repo each 5 minutes
	Unit = "autodeploy.service";
      };
    };

    systemd.services.autodeploy = {
      enable = false; #For production
      description = "Website autodeploy service";
      serviceConfig = {
        User = "${user}";
	WorkingDirectory = "${rootFolder}";
      };

      path = [ pkgs.git ];

      script = ''
      if [ ! -d "./projecttransparency.org" ]; then
        git clone git@github.com:santiment/projecttransparency.org
      fi

      cd projecttransparency.org
      git checkout master
      git pull
      composer install
      '';
    };
    
    # The NixOS release to be compatible with for stateful data such as databases.
    system.stateVersion = "17.09";

  }
