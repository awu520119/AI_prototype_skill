# 高保真 AI 原型工作流

一套用于制作后台高保真原型、编写配套 PRD，并将两者整理为可分享查看器的 Codex Skills。

## 两个 Skill

| Skill | 作用 |
| --- | --- |
| [`admin-prototype`](admin-prototype/SKILL.md) | 基于 React、Ant Design 和本地 Mock 创建或迭代后台 Demo；按页面规范制作列表、详情及抽屉，并可将原型与 PRD 发布到查看器。 |
| [`prototype-viewer`](prototype-viewer/SKILL.md) | 维护左侧目录、中间原型、右侧说明的三栏查看器；合并手写页面与 Demo 发布页，并导出单文件离线版本。 |

两个 Skill 可以配合使用：先制作后台 Demo 和 PRD，再发布到查看器中集中评审和分享。各目录中的 `SKILL.md` 包含完整用法。

## 核心操作

以下命令从仓库根目录开始执行。需要 Node.js、npm 和 Python 3；初始化后台 Demo 时会自动安装 npm 依赖。

```bash
# 1. 创建查看器，并将后台 Demo 绑定到它
bash prototype-viewer/scripts/init-viewer.sh ./demo-viewer
bash admin-prototype/scripts/init-demo.sh demo-admin --viewer ./demo-viewer

# 2. 修改 admin-demo-code/demo-admin/src/、docs/ 和 prototype-pages.json 后发布
cd admin-demo-code/demo-admin
npm run publish:viewer

# 3. 导出可直接打开的离线 HTML
cd ../../demo-viewer
python3 scripts/export_single_file.py . --force
```

导出文件位于 `demo-viewer/share/prototype-viewer.html`。本地预览 Demo 可在 Demo 目录运行 `npm run dev`。若手动修改查看器的 `pages/`、`desc/` 或 `nav.manual.json`，先在查看器目录运行 `python3 scripts/sync_project.py .`，再导出。

首次发布 React 原型前，需要安装浏览器检查依赖：`python3 -m pip install playwright`，然后运行 `python3 -m playwright install chromium`。

根目录的 [`v2.0.1_原型查看器html.html`](v2.0.1_原型查看器html.html) 是一份可直接打开的离线示例，仅保留订单管理和任务管理。
