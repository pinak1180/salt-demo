imagemagick_deps:
  cmd.run:
    - name: apt-get build-dep imagemagick -y -q
    - unless: command -v convert

imagemagick:
  pkg:
    - installed
