define winweb::domain (
  $weblogic_create_domain = hiera('weblogic_createdomain'),
  $weblogic_domain_file = hiera('weblogic_domainfile'),
  $weblogic_wlst_path = hiera('weblogic_wlstpath'),
  $weblogic_service_path = hiera('weblogic_servicepath'),
  $weblogic_nodemanager_path = hiera ('weblogic_nodemanagerpath'),
  $java_home_directory = hiera('java_homedir')
  ) {

file { "$weblogic_domain_file":
      ensure  => file,
      mode   => '777',
      provider => 'windows',
      path   => "${weblogic_wlst_path}${weblogic_domain_file}",
      source  => "${weblogic_source_installer_directory}${weblogic_domain_file}",
      source_permissions => 'ignore',
     }

file { "${weblogic_wlst_path}${weblogic_domain_file}":
      ensure  => file,
      content => template("$module_name/domain.erb"),
      #require => Exec["move-xcenter-wars"]
    }

exec { "create_domain_windows":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd     => "$weblogic_wlst_path",
	provider => 'windows',
        command => "cmd.exe /c  wlst.cmd $weblogic_domain_file ",
        logoutput => true,
		
    }

file { "${weblogic_nodemanager_path}/nodemanager.properties":
      ensure  => file,
      content => template("$module_name/nodemanagerprp.erb"),
      #require => Exec["move-xcenter-wars"]
    } 

exec { "initiate_weblogic_domain_windows":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd     => "$weblogic_service_path",
	provider => 'windows',
        command => "cmd.exe /c  start setDomainEnv.cmd",
        #timeout => 6800,
        logoutput => true,
    }

exec { "initiate_weblogic_service_windows":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd     => "$weblogic_service_path",
	provider => 'windows',
        command => "cmd.exe /c  start startWebLogic.cmd ",
        #timeout => 6800,
        logoutput => true,
    }

exec { "initiate_weblogic_Nodemanager_windows":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd     => "$weblogic_service_path",
	provider => 'windows',
        command => "cmd.exe /c start startNodeManager.cmd ",
        #timeout => 6800,
        logoutput => true,
		
    }
}