##################################################################
#                   Scripted By : Shiva Kumar                    #
#                   Scripted On : 15/08/2023                     #
##################################################################

#! /bin/bash
export ACCESS_TOKEN=${1}
export TEMPLATE_OWNER=shivakumar26011999
export TEMPLATE_REPO=TodoApp
export USERNAME=shivakumar26011999

function createRepository() {
  local REPO_NAME=${1}
  curl -u "${USERNAME}:${ACCESS_TOKEN}" https://api.github.com/user/repos -d '{"name":"'${REPO_NAME}'"}' > /dev/null

  if [ $? = 0 ]; then
    echo "CREATE :: Repository created."
  else
    echo "ERROR :: Failed creating repository."
  fi
} 

function deleteRepository() {
  local REPO_NAME=${1}
  curl -L \
  -X DELETE \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/${USERNAME}/${REPO_NAME}

  if [ $? = 0 ]; then
    echo "SUCCESS :: Repository deleted."
  else
    echo "ERROR :: Failed deleting repository."
  fi
}

function getPublicRepositories() {
  # To get public repositories from github.
  repositories=$(curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/user/repos \
    | jq '.[] | .name')

  for reponame in ${repositories}
  do 
    echo ${reponame}
  done
}

function isRepositoryExists() {
  # To check a particular repository exists.
  # Redirect output to /dev/null if there is no requirement to print output to terminal. 
  REPO_NAME=${1}
  curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${ACCESS_TOKEN}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/repos/shivakumar26011999/${REPO_NAME} > /dev/null

  if [ $? = 0 ]; then
    echo "SUCCESS :: Repository Exists."
  else 
    echo "ERROR :: Please check your details passed(access_token). Repository doesn't exists."
  fi
}

if [ $# -ne 1 ]; then 
  echo "ERROR :: Only one / Atleast one argument should be passed."
  exit 1
fi

echo "====== GitHub Operations ======"
echo "Select required option below"
echo "GET PUBLIC REPOSITORIES     - Select A"
echo "REPOSITORY EXISTANCE        - Select B"
echo "CREATE REPOSITORY           - Select C"
echo "DELETE REPOSITORY           - Select D"

read -p "Enter the option: " option

case ${option} in
  A) getPublicRepositories
     ;;
  B) read -p "Enter repo name: " repo_name
     isRepositoryExists ${repo_name}
     ;;
  C) read -p "Enter repo name: " repo_name
     createRepository ${repo_name}
     ;;
  D) read -p "Enter repo name: " repo_name
     deleteRepository ${repo_name}
     ;;
  *) echo "Please select valid option in given list."
     esac