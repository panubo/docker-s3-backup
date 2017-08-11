FROM panubo/s3fs:1.80

ADD backup.sh /

ENTRYPOINT ["/entry.sh"]

CMD ["/backup.sh"]
