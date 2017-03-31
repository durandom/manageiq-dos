FROM manageiq/manageiq:latest
ARG DUMP=pg_dump.backup

COPY "${DUMP}" /tmp/pg_dump.backup

RUN cp config/database.pg.yml config/database.yml
RUN source /etc/default/evm && \
  su postgres -c "initdb -D ${APPLIANCE_PG_DATA}" && \
  su postgres -c "pg_ctl -D ${APPLIANCE_PG_DATA} start" && \
  sleep 5 && \
  su postgres -c "psql -c \"CREATE ROLE root SUPERUSER LOGIN PASSWORD 'smartvm'\"" && \
  su postgres -c "createdb vmdb_production" && \
  cp ${APP_ROOT}/config/database.pg.yml ${APP_ROOT}/config/database.yml && \
  /usr/bin/memcached -u memcached -p 11211 -m 64 -c 1024 -l 127.0.0.1 -d && \
  su postgres -c "pg_restore --verbose --dbname=vmdb_production /tmp/pg_dump.backup" || true && \
  ${APP_ROOT}/bin/rails db:migrate && \
  bundle exec ruby tools/fix_auth.rb -k vmdb_production && \
  bundle exec ruby tools/fix_auth.rb -v -i smartvm vmdb_production && \
  su postgres -c "pg_ctl -D ${APPLIANCE_PG_DATA} stop" && \
  rsync -av /var/opt/rh/rh-postgresql95/lib/pgsql/data /var/ && \
  rm -rf /var/opt/rh/rh-postgresql95/lib/pgsql/data/* && \
  systemctl enable rh-postgresql95-postgresql && \
  rm /tmp/pg_dump.backup

# give systemd the correct shutdown signal
STOPSIGNAL SIGRTMIN+3
COPY entrypoint /usr/bin
ENTRYPOINT ["entrypoint"]
CMD [ "/usr/sbin/init" ]
