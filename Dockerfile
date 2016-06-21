FROM panubo/s3fs

ADD backup.sh /

ENTRYPOINT ["/entry.sh"]

CMD ["/backup.sh"]
