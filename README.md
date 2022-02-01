# techchallenge
OracleClientInstall.yaml file installs Oracle Client 19c on Linux application server and fetch data from Oracle database server and pushes the output CSV file to Ansible host. Main working directory is /home/ansible/Documents/Ansible.

It requires the client installation files to be downloaded from Oracle site and placed in /home/ansible/Documents/Ansible directory for this install to work.

oracle_client_19c.rsp:

This is client installation response file for silent installation of Oracle client.

sampledata.sql:

This SQL file contains data generation scipt and reporting the required data in CSV format.

Task items are self explanatory.

  tasks:

 
 - name: Create Client Home directory if it does not exist
      file:
       path: /u01/app/oracle/product/19.3.0/client_1
       state: directory
       owner: oracle
       group: oinstall
       mode: '0755'

  
  - name: Install the latest version of oracle-database-preinstall-19c package
      yum:
       name: oracle-database-preinstall-19c
       state: latest

 
 - name: Copy response file for client installation
      copy: src=/home/ansible/Documents/Ansible/oracle_client_19c.rsp dest=/home/oracle/oracle_client_19c.rsp mode=0777

 
 - name: Copy Installation files to appserver and unzip the files
      unarchive: src=/home/ansible/Documents/Ansible/LINUX.X64_193000_client.zip dest=/home/oracle

 
 - name: Install Oracle client 19c
      command: "/home/oracle/client/runInstaller -silent -showProgress -ignorePrereq -ignoreSysPrereqs -waitforcompletion -responseFile /home/oracle/oracle_client_19c.rsp"
      register: client_runinstaller_output
      failed_when: "'Successfully Setup Software' not in client_runinstaller_output.stdout"

 
 - name: run root.sh for client configuration
      command: /u01/app/oracle/product/19.3.0/client_1/root.sh
      become: true
      become_method: su
      become_user: root

 
 - name: Copy sampledata.sql to appserver
      copy: src=/home/ansible/Documents/Ansible/sampledata.sql dest=/home/oracle/sampledata.sql mode=0777

  
  - name: Execute sampledata.sql using sqlplus to generate data and CSV file 
      shell: "echo exit | $ORACLE_HOME/bin/sqlplus -s {{user_name }}/{{ password }}@'{{ servicename }}' @/home/oracle/test.sql"
      environment:
        ORACLE_HOME: "{{oracle_home_path}}"
        LD_LIBRARY_PATH: "{{ld_library_path}}"
        PATH: "{{bin_path}}"

  
  - name: Store file into Ansible host
      fetch:
       src: /tmp/gathered_data.csv
       dest: /tmp/
       flat: yes
   
