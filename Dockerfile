FROM alpine

RUN apk -U --no-cache upgrade
RUN apk -U --no-cache add bash samba-common-tools samba tzdata
RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY scripts/start.sh /
RUN chmod +x /start.sh

RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 445

HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L \\localhost -U % -m SMB3

ENTRYPOINT ["/start.sh"]