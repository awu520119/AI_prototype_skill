# 高保真 AI 原型工作流

一套用于制作后台高保真原型、编写配套 PRD，并将两者整理为可分享查看器的 Codex Skills。

## 两个 Skill

| Skill | 作用 |
| --- | --- |
| [`admin-prototype`](admin-prototype/SKILL.md) | 基于 React、Ant Design 和本地 Mock 创建或迭代后台 Demo；按页面规范制作列表、详情及抽屉，并可将原型与 PRD 发布到查看器。 |
| [`prototype-viewer`](prototype-viewer/SKILL.md) | 维护左侧目录、中间原型、右侧说明的三栏查看器；合并手写页面与 Demo 发布页，并导出单文件离线版本。 |

两个 Skill 可以配合使用：先制作后台 Demo 和 PRD，再发布到查看器中集中评审和分享。各目录中的 `SKILL.md` 包含完整用法。

根目录的 [`v2.0.1_原型查看器html.html`](v2.0.1_原型查看器html.html) 是一份可直接打开的离线示例，仅保留订单管理和任务管理。
