### Usage


```
docker-compose run jekyll bundle install
```
- This command runs the `bundle install` command in the `jekyll` service defined in the `docker-compose.yml` file.
- The `docker-compose run` command creates and starts a container for the `jekyll` service, runs the specified command (`bundle install`), and then stops the container after the command completes.
- **Purpose**: It installs the Ruby dependencies listed in the `Gemfile` into the container, ensuring all necessary gems for the Jekyll project are installed without starting the full service.


```
docker-compose up
```
  - This command starts up all the services defined in your `docker-compose.yml` file, including the `jekyll` service.
  - The `jekyll` service, as defined, runs `jekyll serve --watch --host 0.0.0.0` inside the container, which starts the Jekyll development server.
  - The site will be served at `http://localhost:4000`, and it will automatically rebuild when changes are detected (due to the `--watch` flag).
  - **Purpose**: This starts the containerized Jekyll server and serves the website on your local machine.



we can access it on [http://localhost:4000](http://localhost:4000)

### License

- The HTML and CSS are copyrighted to [AlienWp](http://alienwp.com/) under [GPL license, version 2](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html).

- The written textual contents available in the blog is licensed under Apache 2.0.
