rm -rf ./_book
gitbook build
gitbook pdf ./ ./_book/ebook/RxJS5基本原理.pdf
gitbook mobi ./ ./_book/ebook/RxJS5基本原理.mobi
gitbook epub ./ ./_book/ebook/RxJS5基本原理.epub
git checkout gh-pages
git pull origin gh-pages
cp -rf ./_book/* ./
git add .
git commit -m 'chore(docs): regenerated book'
git push origin gh-pages