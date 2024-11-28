show-shortcut-note 'running git-init'

# TODO: -- Default Dev Branch

if (not $Global:OSGitDefaultBranch){
   Write-Host "Setting Global Variable OSGitDefaultBranch Branch to 'main'"
   $Global:OSGitDefaultBranch = 'main'    
}

if (not $Global:OSGitDevBranch){
   Write-Host "Setting Global Variable OSDevBranch Branch to 'dev'"
   $Global:OSDevBranch = 'dev'
}


git config --global core.longpaths true

# Checkout to the 'dev' branch and pull the latest changes if necessary
$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -ne $Global:OSGitDevBranch) {
   Write-Host "Checking if $Global:OSGitDevBranch branch exists..."
   $devBranchExists = git branch --list $Global:OSGitDevBranch
   if (-Not $devBranchExists) {
       $devOriginBranchExists = git branch -r --list origin/$Global:OSGitDevBranch
          if (-Not $devOriginBranchExists) {
               Write-Host "$Global:OSGitDevBranch branch does not exist. Creating new $Global:OSGitDevBranch branch from '$Global:OSGitDefaultBranch'..."
               git checkout -b dev $Global:OSGitDefaultBranch
               git push -u origin $Global:OSGitDevBranch
          }
          else
          {
               Write-Host "$Global:OSGitDevBranch branch does not exist. Creating new $Global:OSGitDevBranch branch from 'origin/$Global:OSGitDevBranch'..."
               git checkout -b dev origin/$Global:OSGitDevBranch
               git pull -u origin $Global:OSGitDevBranch
          }
   } else {
       Write-Host "Switching to $Global:OSGitDevBranch branch..."
       git checkout $Global:OSGitDevBranch
       git pull origin $Global:OSGitDevBranch
   }
} else {
   # Get the latest from the repository if already on $Global:OSGitDevBranch branch
   git pull origin
}
