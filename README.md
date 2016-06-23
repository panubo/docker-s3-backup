# S3FS Backup

Simple backup container. Creates a single compressed tar file and uploads to an
s3 bucket. Optionally encypted with AES-256-CBC.

## Configuration

See [panubo/s3fs](https://github.com/panubo/docker-s3fs) for S3 configuration
options.

- `BACKUP_KEEP` - Days to retain backups (Default `0`, disabled).
- `BACKUP_DST` - Backup Destination (Default `/mnt/s3`)
- `BACKUP_SRC` - Files to backup eg `/mnt/foo /mnt/bar`
- `BACKUP_TMP` - Temp working space (Default `/tmp`)
- `BACKUP_NAME` - Name of backup (Default `$(date +%Y%m%d%H%M%S)`)
- `BACKUP_EXCLUDE` - Files to exclude
- `BACKUP_PASSPHRASE` - Optional encyption key /passphrase

## Note

For best practice use an append-only bucket policy (no delObject permission)
w/ expiry (object lifecycle policy).
