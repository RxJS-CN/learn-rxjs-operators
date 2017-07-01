rm -rf ./_book
mkdir about
cp README.md ./about/README.md
gitbook build
rm -rf ./about
mkdir ./_book/ebook
gitbook pdf ./ ./_book/ebook/学习RxJS操作符.pdf
gitbook mobi ./ ./_book/ebook/学习RxJS操作符.mobi
gitbook epub ./ ./_book/ebook/学习RxJS操作符.epub
git checkout gh-pages
git pull origin gh-pages
cp -rf ./_book/* ./
git add .
git commit -m 'chore(docs): regenerated book'
git push origin gh-pages