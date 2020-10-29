#!/bin/sh -l

cd /github/workspace
mkdir pdf_out

cd /github/workspace/$1

for f in *.md; do
    [ -f "$f" ] || break
    fn=$(basename "$f" .md)
    echo "📄 Processing $fn ..."
    node /home/marp/.cli/marp-cli.js $f --allow-local-files -o "../pdf_out/${fn}.pdf"
    git add "${fn}.pdf"
done

cd /github/workspace

# Create empty branch and remove all files (maybe copy the LICENSE into pdf_out/ before?)
git checkout --orphan $2
git reset --hard

# Moving the contents from pdf_out to the root of the repository
mv pdf_out/* ..
rm -r pdf_out/

git status
git config user.name "$GITHUB_ACTOR"
git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
git add .
git commit -m 'marp-action publish'
git push --force --set-upstream origin $2