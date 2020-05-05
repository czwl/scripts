


curl -D headers -H "Accept: application/json" -H "Content-Type: application/json"  -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$OWNER/$REPO/events?per_page=150"


#curl -i -H "Authorization: token $GITHUB_TOKEN"  -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '{"ref":"refs/heads/D-commit", "sha":"384f275933d5b762cdb27175aeff1263a8a7b7f7"}' https://api.github.com/repos/<user>/<repo>/git/refs
