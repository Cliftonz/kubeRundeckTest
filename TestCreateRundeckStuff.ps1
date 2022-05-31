$url = "http://http://localhost:4440"
$repoProject = "Test"
$token = "ygVUEeBGaql3AOsrwDLC2PLvbI0GOx4V"


# If project exists or create project
# https://docs.rundeck.com/docs/api/rundeck-api.html#listing-projects
# https://docs.rundeck.com/docs/api/rundeck-api.html#project-creation

$exists = $false
foreach($project in $(Get-AllRundeckProjects -baseUrl $url -token $token)){
    if($project -eq $repoProject){
        $exists = $true
        break
    }
}

if( -not $exists){
    New-RundeckProject -baseUrl $url -token $token -projectName $repoProject

    # Set up correct ACLs for AD Groups
    # https://docs.rundeck.com/docs/api/rundeck-api.html#project-acls
    # TODO

}

# For each job in repository

# See if job exists and create
# https://docs.rundeck.com/docs/api/rundeck-api.html#listing-jobs
$jobExists = $false
foreach($job in $(Get-AllRundeckProjectJobs -baseUrl $url -token $token -projectName $repoProject)){
    if($job -eq $currentJob){
        $jobExists = $true
        break
    }
}

if($jobExists){

    # Update Job
    # https://docs.rundeck.com/docs/api/rundeck-api.html#importing-jobs
    # https://docs.rundeck.com/docs/api/rundeck-api.html#exporting-jobs

}else{
    # Create
    # https://docs.rundeck.com/docs/api/rundeck-api.html#importing-jobs

}

# Check if job requires a webhook and send webhook to some system
# Figure out some way to check which webhook is which or commit the webhook to git
#foreach($webhook in $(Get-AllRundeckProjectWebhooks -baseUrl $url -token $token -projectName $repoProject )){
#    if($webhook.config.jobId -eq $jobId){
#
#    }
#}


# End loop

function Get-AllRundeckProjects {
    param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $baseUrl,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $token
    )

    $uri = [uri]"{0}/api/41/projects" -f $baseUrl
    $headers = @{
        "X-Rundeck-Auth-Token" = $token
    }
    Write-Verbose $uri
    return Invoke-RestMethod -Method GET -Uri $uri -Headers $headers

}

function Get-AllRundeckProjectJobs{
    param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $baseUrl,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $projectName,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $token
    )

    $uri = [uri]"{0}/api/41/project/{1}/jobs" -f $baseUrl, $projectName
    $headers = @{
        "X-Rundeck-Auth-Token" = $token
    }
    Write-Verbose $uri
    return Invoke-RestMethod -Method GET -Uri $uri -Headers $headers
}

function Get-AllRundeckProjectWebhooks{
    param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $baseUrl,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $projectName,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $token
    )

    $uri = [uri]"{0}/api/41/project/{1}/webhooks" -f $baseUrl, $projectName
    $headers = @{
        "X-Rundeck-Auth-Token" = $token
    }
    Write-Verbose $uri
    return Invoke-RestMethod -Method GET -Uri $uri -Headers $headers

}


function New-RundeckProject {
    param(
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $baseUrl,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $projectName,
        [Parameter(Mandatory=$True)]
        [ValidateNotNullOrEmpty()]
        $token
    )

    $uri = [uri]"{0}/api/41/projects" -f $baseUrl
    $body = @{
        name = $projectName
        # Will need to be done for real
#        config = @{
#            propname
#        }
    }

    $headers = @{
        "X-Rundeck-Auth-Token" = $token
    }

    Write-Verbose $uri
    Write-Verbose $body

    return Invoke-RestMethod -Method Post -Uri $uri -Body $body -ContentType "application/json" -Headers $headers

}


