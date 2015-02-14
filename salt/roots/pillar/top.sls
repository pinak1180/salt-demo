# See https://github.com/saltstack-formulas and
# https://github.com/saltstack-formulas/mysql-formula/blob/master/pillar.example
mysql:
  server:
    user: mysql
    root_password: False

  # Manage databases
  database:
    - ems_development
    - ems_test

  user:
    - name: ems
      password: ~
      host: localhost
      databases:
        - database: ems_development
          grants: ['all privileges']
        - database: ems_test
          grants: ['all privileges']
