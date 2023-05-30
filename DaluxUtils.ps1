[string]$DaluxAPIKey = "[API KEY]"
[string]$DaluxURLEndpoint = "https://field.dalux.com/service/APIv2/FieldRestService.svc"


Function Get-DaluxProjects {
 $projectsURLEndpoint = "/projects?key=$DaluxAPIKey"

 $headers = @{
    Authorization=$DaluxAPIKey
}

    $RESTData = Invoke-RestMethod -Method Get -Uri $($DaluxURLEndpoint + $projectsURLEndpoint) -ContentType "application/json" -Headers $headers 

    $CustomObject = @()
    $R = $null

    Foreach ($R in $RESTData) {

        $RESTObject = $RESTData.objects."$($RestObjectName)".fields
        $temp = "" | Select-Object ProjectID, Address, BoxType, ClosingDateTime, CreationDateTime, Name,  Number, Status        
        $temp.Address = $R.Address
        $temp.ProjectID = $R.ProjectID.ID
        $temp.BoxType = $R.BoxType
        $temp.ClosingDateTime = $R.ClosingDateTime
        $temp.CreationDateTime = $R.CreationDateTime
        $temp.Name = $R.Name
        $temp.Number = $R.Number
        $temp.Status = $R.Status
        
        $CustomObject += $temp

    }

    Return $CustomObject


}


Function Get-DaluxIssuesAll ([string]$ProjectID) {
    $ProjectID = "000000"  #TODO

    $projectsURLEndpoint = "/projects/$ProjectID/issues?key=$DaluxAPIKey" 
   
       $RESTData = Invoke-RestMethod -Method Get -Uri $($DaluxURLEndpoint + $projectsURLEndpoint) -ContentType "application/json"
   
       $CustomObject = @()
       $bookMark = ""
       $R = $null
   
       Foreach ($R in $RESTData.IssueList) {

           $temp = "" | Select-Object IssueID, IssueNumber, IssueRevisionList, SafetyIssue, CreatedByUser, CreatedDateTime,  ExtensionsDataList, InspectionType, IsDeleted, LocationList, Project,RoleName        
           
           $temp.IssueID = $R.IssueID
           $temp.IssueNumber = $R.IssueNumber
           $temp.IssueRevisionList = $R.IssueRevisionList
           $temp.SafetyIssue = $R.SafetyIssue
           $temp.CreatedByUser = $R.CreatedByUser
           $temp.CreatedDateTime = $R.CreatedDateTime
           $temp.ExtensionsDataList = $R.ExtensionsDataList
           $temp.InspectionType = $R.InspectionType

           $temp.IsDeleted = $R.IsDeleted
           $temp.LocationList = $R.LocationList
           $temp.Project = $R.Project
           $temp.RoleName = $R.RoleName
          
           $CustomObject += $temp
   
       }

       $bookMark = $RESTData.NextBookmark
      
       Return $CustomObject

   }


  # /projects/{projectid}/checklists? bookmark={bookmark} 
   Function Get-DaluxChecklists([string]$ProjectID) {
    $ProjectID = "0110000"  #TODO

    $projectsURLEndpoint = "/projects/$ProjectID/checklists?key=$DaluxAPIKey" 
   
       $RESTData = Invoke-RestMethod -Method Get -Uri $($DaluxURLEndpoint + $projectsURLEndpoint) -ContentType "application/json"
   
       $CustomObject = @()
       $bookMark = ""
       $R = $null
   
       Foreach ($R in $RESTData.Checklists) {

           $temp = "" | Select-Object BuildingObjectInfo, ChecklistID, ChecklistName, ChecklistNumber, Closed, CreatedByUser,  CreatedDateTime, ExtensionsDataList, IsDeleted, LastModifiedByUser, LastModifiedDateTime,LocationList,Project, Safety,ViewPointImageList      
           
           $temp.BuildingObjectInfo = $R.BuildingObjectInfo
           $temp.ChecklistID = $R.ChecklistID.ID
           $temp.ChecklistName = $R.ChecklistName
           $temp.ChecklistNumber = $R.ChecklistNumber
           $temp.Closed = $R.Closed
           $temp.CreatedByUser = $R.CreatedByUser
           $temp.ExtensionsDataList = $R.ExtensionsDataList
 
           $temp.IsDeleted = $R.IsDeleted
           $temp.LastModifiedByUser = $R.LastModifiedByUser
           $temp.LastModifiedDateTime = $R.LastModifiedDateTime
           $temp.LocationList = $R.LocationList
           $temp.Project = $R.Project
           $temp.Safety = $R.Safety
           $temp.ViewPointImageList = $R.ViewPointImageList

           $CustomObject += $temp
   
       }

       $bookMark = $RESTData.NextBookmark
      
       Return $CustomObject

   }  