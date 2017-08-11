FROM panubo/s3fs:1.82

ADD backup.sh /

ENTRYPOINT ["/entry.sh"]

CMD ["/backup.sh"]
