# custom_search_page

A web Flutter project, for import different search engine

## deploy
[https://shadowplusing.website/custom_search_page/](https://shadowplusing.website/custom_search_page/)

## Getting Started
solve flutter web font download event causes bad website speed, change use html render.

flutter run --web-renderer html

flutter build web --web-renderer html --release

## flutter web build
index.html
```
    <base href="/">
=>
    <base href="/custom_search_page/">
```
