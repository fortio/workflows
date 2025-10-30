#! /bin/bash

SED="gsed"
if ! command -v $SED &> /dev/null
then
    echo "gsed could not be found, falling back to sed, might not work on macOS"
    SED="sed"
fi

# Make sure website directory exists
if [ ! -d "./website" ]; then
    echo "Website directory not found! Please run this script from the correct location."
    echo "From ~/github/fortio.org for instance with ./website checked out."
    exit 1
fi


# Enter the name of the new repository
read -r -p "Enter the name of the new repository: " REPO_NAME

# Enter a short description for the repository
read -r -p "Enter a short description for the repository: " REPO_DESC

echo "Creating repository '$REPO_NAME' with description '$REPO_DESC'"

set -x -e

# Create the new repository using GitHub CLI using our template repository
FULL_REPO_NAME="fortio/$REPO_NAME"
gh repo create "$FULL_REPO_NAME" --description "$REPO_DESC" --template "fortio/template" --public --clone

cd "$REPO_NAME"

# Need also on the website:
cp ../website/NAME.md ../website/"$REPO_NAME".md

# Change NAME to $REPO_NAME in all files
# shellcheck disable=SC2046
$SED  -i -e "s/NAME/$REPO_NAME/g" -e "s/DESCRIPTION/$REPO_DESC/g" $(git ls-files) ../website/"$REPO_NAME".md

(cd ../website && git add "$REPO_NAME".md && git commit -m "Add $REPO_NAME to website" && git push)

# Get the dependencies
go mod tidy

# Check it runs:
go run .
git add .
git commit -m "Initial commit for $REPO_NAME"
git push origin main

# Create repository ruleset for main branch protection
gh api -X POST "repos/$FULL_REPO_NAME/rulesets" \
  -H "Accept: application/vnd.github+json" \
  --input - <<EOF
{
  "name": "Main branch protection ruleset",
  "target": "branch",
  "enforcement": "active",
  "bypass_actors": [],
  "conditions": {
    "ref_name": {
      "include": ["refs/heads/main"],
      "exclude": []
    }
  },
  "rules": [
    {
      "type": "pull_request",
      "parameters": {
        "dismiss_stale_reviews_on_push": false,
        "require_code_owner_review": false,
        "require_last_push_approval": false,
        "required_approving_review_count": 0,
        "required_review_thread_resolution": false,
        "allowed_merge_methods": ["squash"]
      }
    },
    {
      "type": "required_linear_history"
    },
    {
      "type": "deletion"
    },
    {
      "type": "non_fast_forward"
    }
  ]
}
EOF


# Allow squash only (redundant with ruleset but kept for clarity)
gh api -X PATCH "repos/$FULL_REPO_NAME" \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -F allow_squash_merge=true \
  -F delete_branch_on_merge=true

gh repo edit "$FULL_REPO_NAME" --allow-update-branch=true

# Disable features that aren't needed
gh api -X PATCH "repos/$FULL_REPO_NAME" \
  -F has_wiki=false \
  -F has_projects=false

echo "Repository $REPO_NAME created and initialized successfully."
