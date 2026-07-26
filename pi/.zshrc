#------------------------------------------------------------------------
# mypi - 在容器中启动 pi
#
#   - 在 ~/workspace/ 或 ~/playground/ 的子目录下
#       叠加 compose.workdir.yaml，将当前目录挂载进容器（WORK_DIR=$PWD）
#       容器内可直接读写当前目录的文件
#   - 其他目录：
#       只用基础 compose.yaml，不挂载当前目录
#       pi-data 命名卷仍然生效，会话历史保留
#------------------------------------------------------------------------
#######
#
# 用法：
#   mypi              # 无参，默认执行 pi
#   mypi <命令及参数>  # 参数原样透传给容器
#
########
mypi() {
  local compose_dir=~/playground/docker/pi
  case "$PWD" in
    "$HOME"/workspace/*|"$HOME"/playground/*)
      WORK_DIR="$PWD" docker compose \
        -f "$compose_dir/compose.yaml" \
        -f "$compose_dir/compose.workdir.yaml" \
        run --rm pi "${@:-pi}"
      ;;
    *)
      docker compose -f "$compose_dir/compose.yaml" run --rm pi "${@:-pi}"
      ;;
  esac
}
