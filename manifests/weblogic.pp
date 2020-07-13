define winweb::weblogic (
  $install_weblogic = hiera('weblogic_install'),
  $weblogic_install_path = hiera('weblogic_installpath'),
  $weblogic_source_installer_directory = "puppet:///TestAutomationFramework/ORACLE_WLS/fmw_12.2.1.3.0_wls/",
  $weblogic_install_filename= hiera('weblogic_installfilename'),
  $weblogic_response_filename = hiera('weblogic_responsefilename'),
  $weblogic_domain_file = hiera('weblogic_domainfile'),
  $weblogic_wlst_path = hiera('weblogic_wlstpath'),
  $weblogic_service_path = hiera('weblogic_servicepath'),
  $weblogic_nodemanager_path = hiera ('weblogic_nodemanagerpath'),
  $java_home_directory = hiera('java_homedir')
  ) {

exec { "create-weblogic-directory":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd       => "c:/",
        command   => "cmd.exe /c mkdir \"$weblogic_install_path\"",
        logoutput => true,
        creates   => "$weblogic_install_path",
      }
 
  file { "$weblogic_install_path":
  ensure => directory,
  recurse => true,
  source_permissions => 'ignore',
  provider => 'windows',
  mode   => '0777',
   }

file { "$weblogic_response_filename":
      ensure  => file,
      mode   => '777',
      provider => 'windows',
      path   => "${weblogic_install_path}${weblogic_response_filename}",
      source  => "${weblogic_source_installer_directory}${weblogic_response_filename}",
      source_permissions => 'ignore',
     }

file { "$weblogic_install_filename":
      ensure  => file,
      mode   => '777',
      provider => 'windows',
      path   => "${weblogic_install_path}${weblogic_install_filename}",
      source  => "${weblogic_source_installer_directory}${weblogic_install_filename}",
      source_permissions => 'ignore',
      
    }


exec { "install-weblogic-windows":
        path => ['C:/OpenSSL-Win64/bin', 'C:/Windows/System32', "$java_home"],
        cwd     => "$java_home_directory",
	command => "cmd.exe /c java -jar ${weblogic_install_path}${weblogic_install_filename} -silent -responseFile ${weblogic_install_path}${weblogic_response_filename}",
        logoutput => true,
		
    }

/*file { "$weblogic_domain_file":
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
		
    }*/

  }
