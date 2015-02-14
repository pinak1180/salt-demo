ruby:
  require:
    - sls: demo.rvm
  cmd.run:
    - user: root
    - name: rvm install 2.2.0
    - unless: rvm list | grep ruby-2.2.0
