# local/ 브랜치 push 방지 pre-push hook

```sh
#!/bin/sh

# pre-push hook: local/ 로 시작하는 브랜치는 어떤 remote 로도 push 불가

while read local_ref local_sha remote_ref remote_sha
do
  branch=$(echo "$remote_ref" | sed 's#refs/heads/##')

  if echo "$branch" | grep -q "^local/"; then
    echo "🚫 local/ 브랜치는 push 할 수 없습니다. (차단된 브랜치: $branch)"
    exit 1
  fi
done

exit 0
```

위 파일을 `.git/hooks/pre-push`로 저장하고 실행 권한을 부여합니다.

```sh
chmod +x .git/hooks/pre-push
```

이제 `local/`로 시작하는 브랜치를 push 하려고 하면 에러 메시지가 출력되고 push가 차단됩니다.