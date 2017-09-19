{ config, pkgs, ... }:
  let
    fcgiSocket = "/run/phpfpm/nginx";
    user = "web";
    group = "web";
    rootFolder = "/vagrant";
  in  
  {

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
      git
      apacheHttpd
    ];

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [22 80 443 ];
    networking.firewall.allowedUDPPorts = [22 80 443 ];

    # Disable the firewall (to simplify development)
    # networking.firewall.enable = false;

    # Enable the X11 windowing system.
    # services.xserver.enable = true;
    # services.xserver.layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";

    # services.xserver.windowManager.i3.enable = true;

    # Enable the KDE Desktop Environment.
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers."${user}" = {
      isNormalUser = true;
      useDefaultShell = true;
      uid = 1000;
      group = "${group}";
      home = "${rootFolder}";
      createHome = true;
    };

    users.extraGroups."${group}".gid = 1000;


    # Postgresql database
    # services.postgresql = {
    #   enable = true;
    #   package = pkgs.postgresql96;
    #   enableTCPIP = true;

    #   authentication = ''
    #    # "local" is for Unix domain socket connections only
    #    local   all             all                                     trust
    #    # IPv4 local connections:
    #    host    all             all             127.0.0.1/32            trust
    #    # IPv6 local connections:
    #    host    all             all             ::1/128                 trust
    #    # Allow replication connections from localhost, by a user with the
    #    # replication privilege.
    #    #local   replication     postgres                                trust
    #    #host    replication     postgres        127.0.0.1/32            trust
    #    #host    replication     postgres        ::1/128                 trust
    #    # Allow all connections from all users
    #    host all all all trust
    #   '';

    #   initialScript = ./pginit.sql;
      
    # };

    

    # PHP config
    # We use php-fpm behind an nginx server

    # services.phpfpm.phpOptions = ''
    #   error_reporting = E_ALL
    #   log_errors = TRUE
    #   error_log = "syslog"
    #   log_level = "debug"
    # '';
    
    
    # services.phpfpm.poolConfigs.nginx = ''
    #   listen = 127.0.0.1:9000
    #   listen.owner = ${user}
    #   listen.group = ${group}
    #   listen.mode = 0660
    #   user = ${user}
    #   pm = ondemand
    #   pm.max_children = 2
    #   catch_workers_output = true
    # '';

          
    # 
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

	  extraConfig = ''
	    auth_basic "Access restricted";
	    auth_basic_user_file ${rootFolder}/.htpasswd;
	  '';

	};
      };
    };
    

    # The NixOS release to be compatible with for stateful data such as databases.
    system.stateVersion = "17.09";

  }
