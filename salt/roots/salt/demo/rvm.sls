rvm:
  cmd.run:
    - name: curl -sSL https://get.rvm.io | bash -s stable
    - unless: test -d /usr/local/rvm
