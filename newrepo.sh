#! /bin/bash

SED=gsed
if ! command -v gsed &> /dev/null
then
    echo "gsed could not be found, falling back to sed, might not work on macOS"
    SED=sed
fi

# Make sure website directory exists
if [ ! -d "./website" ]; then
    echo "Website directory not found! Please run this script from the correct location."
    echo "From ~/github/fortio.org for instance with ./website checked out."
    exit 1
fi

set -x -e

# Enter the name of the new repository
read -p "Enter the name of the new repository: " REPO_NAME

# Enter a short description for the repository
read -p "Enter a short description for the repository: " REPO_DESC

# Create the new repository using GitHub CLI using our template repository
gh repo create "$REPO_NAME" --description "$REPO_DESC" --template "fortio/template" --public

# Clone the newly created repository to the local machine
gh repo clone "$REPO_NAME"
cd "$REPO_NAME"

# Need also on the website:
cp ../website/NAME.md ../website/"$REPO_NAME".md

# Change NAME to $REPO_NAME in all files
$SED  -i -e "s/NAME/$REPO_NAME/g" -e "s/DESCRIPTION/$REPO_DESC/g" $(git ls-files) ../website/"$REPO_NAME".md

(cd ../website && git add "$REPO_NAME".md && git commit -m "Add $REPO_NAME to website" && git push)

# Get the dependencies
go mod tidy

# Check it runs:
go run .
git add .
git commit -m "Initial commit for $REPO_NAME"
git push origin main

echo "Repository $REPO_NAME created and initialized successfully."
