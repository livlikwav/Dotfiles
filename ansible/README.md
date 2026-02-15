# Ansible 디렉토리 구조 가이드

## Ansible 핵심 개념

### 1. Playbooks (플레이북)
**역할**: 실행할 작업의 진입점 및 오케스트레이션

- **위치**: `ansible/playbooks/` 또는 `ansible/*.yml`
- **설명**: 어떤 호스트에서 어떤 role/task를 실행할지 정의하는 최상위 파일
- **예시**:
```yaml
# playbooks/main.yml
---
- name: Setup all dotfiles
  hosts: localhost
  roles:
    - zsh
    - vim
    - hammerspoon
```

### 2. Roles (역할)
**역할**: 재사용 가능한 작업 단위를 논리적으로 그룹화

- **위치**: `ansible/roles/<role_name>/`
- **구조**:
```
roles/
└── zsh/
    ├── tasks/
    │   └── main.yml      # 실행할 작업들
    ├── vars/
    │   └── main.yml      # role 전용 변수
    ├── defaults/
    │   └── main.yml      # 기본값 변수
    ├── files/            # 복사할 파일들
    ├── templates/        # Jinja2 템플릿 파일들
    └── handlers/
        └── main.yml      # 이벤트 핸들러
```
- **장점**: 모듈화, 재사용성, 가독성
- **예시**:
```yaml
# roles/zsh/tasks/main.yml
---
- name: Create symlink for .zshrc
  file:
    src: "{{ dotfiles_dir }}/zsh/.zshrc"
    dest: "{{ ansible_facts.env.HOME }}/.zshrc"
    state: link
```

### 3. Group_vars (그룹 변수)
**역할**: 호스트 그룹별 변수 정의

- **위치**: `ansible/group_vars/all.yml`
- **설명**: 모든 호스트(또는 특정 그룹)에 공통으로 적용되는 변수
- **예시**:
```yaml
# group_vars/all.yml
---
dotfiles_dir: "{{ ansible_facts.env.HOME }}/Dotfiles"
backup_dir: "{{ ansible_facts.env.HOME }}/Dotfiles/backup"
```

### 4. Tasks (태스크)
**역할**: 재사용 가능한 작업 목록 (roles보다 가벼운 모듈화)

- **위치**: `ansible/tasks/<name>.yml`
- **설명**: playbook에서 `include_tasks`로 불러와 사용
- **예시**:
```yaml
# tasks/zsh.yml
---
- name: Create symlink for .zshrc
  file:
    src: "{{ dotfiles_dir }}/zsh/.zshrc"
    dest: "{{ ansible_facts.env.HOME }}/.zshrc"
    state: link
```

### 5. Inventory (인벤토리)
**역할**: 관리할 호스트 목록 정의

- **위치**: `ansible/inventory/localhost.ini` 또는 `ansible/hosts`
- **설명**: Ansible이 작업을 수행할 대상 호스트 정의
- **예시**:
```ini
# inventory/localhost.ini
[local]
localhost ansible_connection=local
```

## Tasks vs Roles

| 항목 | Tasks | Roles |
|------|-------|-------|
| 복잡도 | 간단 | 복잡 |
| 구조 | 단일 파일 | 여러 디렉토리/파일 |
| 사용법 | `include_tasks` | `roles:` |
| 변수 관리 | `group_vars` 사용 | role 내부 `vars/`, `defaults/` |
| 적합한 경우 | 작은 프로젝트, 단순 작업 | 큰 프로젝트, 복잡한 로직 |

## CLI 실행 방법

### 기본 실행
```bash
# Playbook 실행 (현재 방식)
ansible-playbook ansible/hammerspoon.yml

# 특정 inventory 지정
ansible-playbook -i ansible/inventory/localhost.ini ansible/playbooks/main.yml

# 특정 role만 실행
ansible-playbook ansible/playbooks/main.yml --tags "zsh"

# dry-run (실제 변경 없이 테스트)
ansible-playbook ansible/playbooks/main.yml --check

# verbose 모드
ansible-playbook ansible/playbooks/main.yml -v
ansible-playbook ansible/playbooks/main.yml -vvv  # 더 상세한 출력
```

### 변수 오버라이드
```bash
# 명령줄에서 변수 전달
ansible-playbook ansible/playbooks/main.yml -e "dotfiles_dir=/custom/path"

# 변수 파일 사용
ansible-playbook ansible/playbooks/main.yml -e "@custom_vars.yml"
```

### 특정 태스크만 실행
```bash
# 태그로 필터링
ansible-playbook ansible/playbooks/main.yml --tags "backup"
ansible-playbook ansible/playbooks/main.yml --skip-tags "backup"
```
