#!/bin/zsh

skills=(
  multica-ai/andrej-karpathy-skills
  UditAkhourii/adhd
  AminBlg/SimpleEnglish
)

for skill in "${skills[@]}"; do
  npx skills add "$skill"
done
