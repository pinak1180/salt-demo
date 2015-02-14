# EMS application dependencies
# todo: sphinxsearch
include:
  - demo.imagemagick
  - demo.rvm
  - demo.ruby
  - mysql
  - redis

ems:
  pkg.installed:
    - pkgs:
      - freetds-dev
      - libxml2-dev
      - libxslt1-dev
      - sphinxsearch
