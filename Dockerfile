FROM panubo/s3fs:1.84

ADD backup.sh /

ENTRYPOINT ["/entry.sh"]

CMD ["/backup.sh"]
