class winweb (

 $project_templates_directory = '/etc/puppetlabs/code/environments/$environment/templates',

) {
include stdlib

 stage { 'Main': }
 
 class { 'winweb::weblogic': stage=> Main, }


}