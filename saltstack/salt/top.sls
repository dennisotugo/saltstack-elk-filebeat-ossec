base:
  '*':
    - common
  'minion01':
    - elk
    - ossec
    - beats.filebeat
  'minion02':
    - beats.filebeat
