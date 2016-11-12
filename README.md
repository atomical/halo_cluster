### Build docker image

docker build -t atomical/sapp .

### Build rails server
`rake db:create && rake db:migrate && rake db:seed`
`rake map:import`

