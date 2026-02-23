azure-vms/
├── ansible.cfg
├── requirements.yml
├── roles/
│   └── azure_vm/
│       ├── README.md
│       ├── defaults/
│       │   └── main.yml
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── nic.yml
│       │   ├── disk.yml
│       │   └── vm.yml
│       └── vars/
│           ├── linux.yml
│           └── windows.yml
├── envs/
│   ├── dev/
│   │   ├── group_vars/
│   │   │   └── all.yml
│   │   └── playbooks/
│   │       ├── vm-dev-app-01.yml
│   │       └── vm-dev-win-01.yml
│   └── prod/
│       ├── group_vars/
│       │   └── all.yml
│       └── playbooks/
│           └── vm-prod-db-01.yml
└── README.md