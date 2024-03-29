"ADO Team Members are:" 

$UriOrganization = "https://dev.azure.com/OrgName/"

#Get all Projects
$ProjectsResult = az devops project list  

$Projects  = $ProjectsResult| ConvertFrom-Json

'ProjectId'+  "`t"+ 'ProjectName'+ "`t"+'Team.id'+"`t"+ 'Team.name' + "`t"+ 'TeamMember.id'+ "`t"+'TeamMember.displayName'+"`t"+ 'TeamMember.uniqueName'

#Iterate through all Projects
Foreach ($projectId in $Projects.value.id )
{
     
        #Get Teams List 
        $TeamsResult = ( (az devops team list  --org $UriOrganization --project $projectId ) | ConvertFrom-Json ) 
        
        #Iterate through each Team 
         Foreach ($Team in  $TeamsResult )
         {
            $TeamMembersResult = (az devops team list-member --team $Team.id --project  $projectId ) | ConvertFrom-Json 
            Foreach ($teamMember in $TeamMembersResult.identity)
             {
                    $projectId + "`t" + $team.projectName + "`t"+$team.id +"`t"+ $team.name + "`t"+$teamMember.id + "`t"+ """" +$teamMember.displayName+ """" +"`t"+ $teamMember.uniqueName

                }
            }
        }
       
