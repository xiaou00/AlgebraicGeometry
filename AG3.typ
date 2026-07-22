#import "template.typ" : *
#import "@preview/fletcher:0.5.8" : *

#show:conf.with(
  title: "代数几何讲义 III",
  subtitle: "景, 叠, 纤维范畴与下降",
  author: "xiaou0",
  date: "2026",
)

= 基础范畴论

本篇默认你熟悉经典的范畴论, 一些 $2$-范畴的概念, 甚至一点点 $oo$-范畴的思想. 当然我们暂时不会提到过于高阶的概念, 但写在这章中的内容是必须理解的.

== Yoneda引理

Yoneda引理是数学里最重要的抽象废话之一:

#theorem(title:[Yoneda引理])[
  设 $C$ 是局部小范畴, $F:C^op->Set$ 是函子, 则对任意对象 $x in C$, 有自然同构
  $ "Nat"(h_x,F) tilde.eq F(x) $
  其中 $h_x = Hom_C (-,x)$.
]

#theorem(title:[Yoneda嵌入])[
  设 $C$ 是局部小范畴, 则有全忠实的嵌入
  $ C -> Fun(C^op,Set) $
  定义为 $x |-> Hom_C (-,x) =: h_x$.
]

上述嵌入称之为*Yoneda嵌入* (Yoneda embedding), 同时形如上述所示的函子称之为*可表函子* (representable functor).

#proof[
  我们把 Yoneda 引理的同构写得更显式一点. 给定自然变换
  $ eta:h_x=>F $
  它对应的元素就是
  $ eta_x(id_x) in F(x) $
  反过来, 给定 $s in F(x)$, 对任意态射 $f:u->x$, 定义
  $ eta_u(f)=F(f)(s) in F(u) $
  这显然关于 $u$ 自然. 两个构造互为逆, 所以得到同构.
]

#remark[
  这条引理的口号是: 一个对象 $x$ 完全由 "别人如何映到它" 决定. 所以以后如果要证明两个对象同构, 很多时候可以改成证明两个可表函子同构. 这就是把几何对象放进函子范畴里的基本理由.
]

== 群对象

=== 群对象的定义

下设范畴 $C$ 具有有限乘积, 并且记 $1$ 为终对象.

#definition(title:[群对象])[
  范畴 $C$ 的一个*群对象* (group object) 是一个对象 $g in C$, 连同一个函子 $C^op->Grp$ 使得其与遗忘函子 $Grp->Set$ 复合后等于 $h_g = Hom_C (-,g)$.
] <def-group-object>

拓扑空间范畴的群对象称之为一个*拓扑群* (topological group), 而在光滑流形范畴的群对象称之为一个*李群* (Lie group). 在概形范畴中, 群对象称之为一个*群概形* (group scheme).

#theorem[
  给出 $g in C$ 的一个群对象结构等价于给出三个态射:
  $ m_g:g times g -> g, quad i_g : g -> g, quad e_g: 1-> g $
  使得下列图表交换

  1. 单位元
  #align(center, diagram({
	node((0, 0), [$1 times g$])
	node((1, -1), [$g times g$])
	node((1, 0), [$g$])
	node((2, -1))
	node((2, 0), [$g times 1$])
	edge((1, -1), (1, 0), [$m_g$], label-side: left, "->")
	edge((0, 0), (1, -1), [$e_g times id_g$], label-side: left, "->")
	edge((0, 0), (1, 0), "=")
	edge((2, 0), (1, -1), [$id_g times e_g$], label-side: right, "->")
	edge((1, 0), (2, 0), "=")
  }))
  2. 结合律
  #align(center, diagram({
	node((1, -1), [$g times g times g$])
	node((2, -1), [$g times g$])
	node((1, 0), [$g times g$])
	node((2, 0), [$g$])
	edge((1, -1), (2, -1), [$m_g times id_g$], label-side: left, "->")
	edge((1, -1), (1, 0), [$id_g times m_g$], label-side: right, "->")
	edge((1, 0), (2, 0), [$m_g$], label-side: right, "->")
	edge((2, -1), (2, 0), [$m_g$], label-side: left, "->")
  }))
  3. 逆元
  #align(center, diagram({
	node((-1, 1), [$g$])
	node((-1, 0), [$g times g$])
	node((0, 1), [$1$])
	node((0, 0), [$g$])
	node((1, 1), [$g$])
	node((1, 0), [$g times g$])
	edge((-1, 1), (-1, 0), [$(i_g,id_g)$], label-side: left, "->")
	edge((0, 1), (0, 0), [$e_g$], label-side: left, "->")
	edge((-1, 1), (0, 1), "->")
	edge((-1, 0), (0, 0), [$m_g$], label-side: left, "->")
	edge((1, 0), (0, 0), [$m_g$], label-side: right, "->")
	edge((1, 1), (1, 0), [$(id_g,i_g)$], label-side: right, "->")
	edge((1, 1), (0, 1), "->")
  }))
]

#proof[
  显然, 在 $Set$ 里, 这些图表给出的就是群公理. 对任意对象 $u in C$, 将上述图表视作函子之间的图表在 $u$ 处取值即可.
]

#remark[
  这个定义看起来像是在范畴里硬画群公理, 但它其实很自然: 普通群就是 $Set$ 中的群对象. 一旦把 $Set$ 换成 $Top$, $"Man"$, $Sch$ 等范畴, 群的乘法、单位元、逆元就必须由相应范畴中的态射给出. 例如在 $Sch$ 中, 乘法不是任意集合映射, 而必须是概形态射.
]

=== 几个重要的群概形

#example[
  对任何 $U in Sch\/S$, 有
  $ Hom_S (U,AA^1_S) tilde.eq Gamma(U,cal(O)_U) $
  是一个Abel群, 显然其表示了函子
  $ h_(AA^1_S):(Sch\/S)^op --> Ab $
  从而 $AA^1_S$ 是一个群概形, 通常记作 $GG_(a,S)$.
]

若 $S=Spec R$, 则 $GG_(a,S)=Spec R[t]$. 它的群结构在坐标环上反向写作
$ R[t] -> R[t_1,t_2], quad t |-> t_1+t_2 $
单位元为
$ R[t] -> R, quad t |->0 $
逆元为
$ R[t] -> R[t], quad t |-> -t $
这就是把通常的加法群写成概形语言.

#example[
  $GG_(m,S) = AA^1_S\\0$ 表示函子
  $ cal(O)^*:(Sch\/S)^op --> Grp $
  将 $S$-概形 $U->S$ 送到 $cal(O)^*(U)$, 即 $U$ 上的可逆正则函数群. 显然其诱导群概形, 称之为*乘法群概形* (multiplicative group scheme), 记作 $GG_(m,S)$.
]

若 $S=Spec R$, 则 $GG_(m,S)=Spec R[t,t^(-1)]$. 乘法在坐标环上为
$ R[t,t^(-1)] -> R[t_1,t_1^(-1),t_2,t_2^(-1)], quad t |-> t_1 t_2 $
单位元为 $t |-> 1$, 逆元为 $t |-> t^(-1)$. 这说明 $GG_m$ 的 $U$-值点确实是 $cal(O)_U (U)^*$.

#example[
  考虑函子
  $ (Sch\/S)^op --> Set $
  将 $S$-概形 $U->S$ 打到 $M_n (cal(O)(U))$ 为 $n times n$ 矩阵群. 这个函子由 $M_(n,S):=AA^(n^2)_S$ 表示, 考虑行列式映射给出的概形态射
  $ det:M_(n,S) --> AA^1_S $
  记 $"GL"_(n,S)$ 为开子概形 $GG_(m,S) subset AA^1_S$ 在 $det$ 下的逆像, 则 $"GL"_(n,S)$ 是一个群概形, 称之为*广义线性群概形* (general linear group scheme).
]

=== 群对象的同态

#definition(title:[群对象同态])[
  若 $g,h$ 是群对象, 则一个*群对象同态* (group object morphism) 是一个态射 $f:g->h$ 使得下列图表交换
  #align(center, diagram({
	node((1, 0), [$g times g$])
	node((1, 1), [$h times h$])
	node((2, 0), [$g$])
	node((2, 1), [$h$])
	edge((1, 0), (1, 1), [$f times f$], label-side: right, "->")
	edge((2, 0), (2, 1), [$f$], label-side: left, "->")
	edge((1, 0), (2, 0), [$m_g$], label-side: left, "->")
	edge((1, 1), (2, 1), [$m_h$], label-side: right, "->")
  }))
]

固定范畴 $C$ 后所有群对象构成一个范畴 $Grp(C)$. 若 $F:C->D$ 是保持有限乘积的函子, 不难验证其诱导函子 $Grp(F):Grp(C)->Grp(D)$ 也是一个函子.

#example[
  若 $C=Sch\/S$, 群对象同态 $GG_(m,S)->GG_(m,S)$ 可以由整数 $n in ZZ$ 给出:
  $ x |-> x^n $
  在坐标环上对应
  $ R[t,t^(-1)] -> R[t,t^(-1)], quad t |-> t^n $
  当 $n=0$ 时得到常值为单位元的同态. 这类例子提醒我们: 几何态射方向和坐标环同态方向相反, 不要看反了喵.
]

== 群对象的作用

#definition(title:[群对象作用])[
  设 $G:C^op->Grp$ 是群值函子, $F:C^op->Set$ 是集合值函子, 则 $G$ 在 $F$ 上的一个*作用* (action) 是一个自然变换 $alpha:G times F => F$ 使得对任意 $x in C$, 诱导的映射
  $ G(x) times F(x) -> F(x) $
  是一个群作用. 记作 $alpha:G act F$. 特别地, 我们称 $G$ 在对象 $x in C$ 上的一个作用是在可表函子 $h_x$ 上的一个作用.
] <def-group-action>

也就是说群作用就是对每个 $x in C$, 给出 $G(x)$ 在 $F(x)$ 上的一个群作用, 并且这些作用在 $C$ 的态射下是自然的. 我们也可以用图表来定义

#example[
  若 $G$ 是普通群, 把它看作 $Set$ 中的群对象, 那么 $G$ 在集合 $X$ 上的作用就是通常的映射
  $ G times X -> X $
  满足 $e x=x$ 和 $(g h)x=g(h x)$. 若 $G$ 是群概形, $X$ 是概形, 那么 $G$ 在 $X$ 上的作用则是概形态射
  $ G times_S X -> X $
  并且对所有 $S$-概形 $U$ 的 $U$-值点给出兼容的普通群作用.
]

#theorem[
  给出一个群对象 $g$ 在对象 $x$ 上的作用等价于给出一个态射 $alpha:g times x -> x$ 使得下列图表交换:

  1. 单位元
  #align(center, diagram({
	node((1, 0), [$1 times x$])
	node((2, 1), [$x$])
	node((2, 0), [$g times x$])
	edge((1, 0), (2, 1), "=")
	edge((2, 0), (2, 1), [$alpha$], label-side: left, "->")
	edge((1, 0), (2, 0), [$e_g times id_x$], label-side: left, "->")
  }))
  2. 结合律
  #align(center, diagram({
	node((1, 0), [$g times g times x$])
	node((1, 1), [$g times x$])
	node((2, 1), [$x$])
	node((2, 0), [$g times x$])
	edge((1, 0), (2, 0), [$m_g times id_x$], label-side: left, "->")
	edge((1, 0), (1, 1), [$id_g times alpha$], label-side: right, "->")
	edge((1, 1), (2, 1), [$alpha$], label-side: right, "->")
	edge((2, 0), (2, 1), [$alpha$], label-side: left, "->")
  }))
  
  此时记作 $alpha:g act x$. (或 $h_g act h_x$).
]

所谓等变就是指一个映射与群作用相容, 我们可以推广到群对象

#definition(title:[$G$-等变])[
  设 $x,y$ 是 $C$ 中带有 $G$-作用的对象, 则一个态射 $f:x->y$ 称之为*等变* (equivariant) 的, 当且仅当对任何对象 $u in C$, 诱导的
  $ x(u) -> y(u) $
  都是 $G(u)$-等变的. 这里 $x(u)$ 记号是指 $x$ 的 $u$-值点. 即 $Hom_C (u,x)$.
]

等价地, $f$ 是 $G$-等变的当且仅当下列图表交换
#align(center, diagram({
  node((1, 0), [$g times x$])
  node((1, 1), [$g times y$])
  node((2, 0), [$x$])
  node((2, 1), [$y$])
  edge((1, 0), (1, 1), [$id_g times f$], label-side: right, "->")
  edge((2, 0), (2, 1), [$f$], label-side: left, "->")
  edge((1, 0), (2, 0), [$alpha_x$], label-side: left, "->")
  edge((1, 1), (2, 1), [$alpha_y$], label-side: right, "->")
}))

= 景与层

在经典的代数几何里, 我们已经充分接触了拓扑空间上的层. 景是对这一概念的推广. 

#remark[
  直观地说, 景允许我们把 "开覆盖" 换成更灵活的 "测试对象覆盖". 在 Zariski 拓扑里, 一个对象的局部片段确实是开子概形; 在 étale 或 fppf 拓扑里, 局部片段可以不是开嵌入, 但仍然足够像局部坐标图. 这正是代数几何中很多对象必须用更细拓扑才能看清楚的原因.
]

== Grothendieck拓扑

在Grothendieck拓扑里, 一个空间的"开集"是指向这个空间的态射, 交集用纤维积代替.

=== 景的定义

#definition(title:[景])[
  设 $C$ 是范畴, $C$ 上的一个*Grothendieck拓扑* (Grothendieck topology) 给每个对象 $u$ 分配了一族形如 ${u_i->u}_i$ 的*覆盖* (cover), 使得下列条件成立:

  1. 若 $v->u$ 是同构, 则 ${v->u}$ 是 $u$ 的覆盖.
  2. 若 ${u_i->u}_i$ 是 $u$ 的覆盖, 且 $v->u$ 是任意态射, 则 ${u_i times_u v -> v}_i$ 是 $v$ 的覆盖.
  3. 若 ${u_i->u}_i$ 是 $u$ 的覆盖, 对每个 $i$ 有 ${v_(i j)-> u_i}_j$ 是 $u_i$ 的覆盖, 则 ${v_(i j)-> u_i -> u}_(i j)$ 是 $u$ 的覆盖.

  配备了Grothendieck拓扑的范畴称之为*景* (site). 通常记一个对象 $u$ 的覆盖族为 $"Cov"(u)$.
]

=== 一些常见的景

#example(title:[拓扑空间的景])[
  设 $X$ 是拓扑空间, 记 $X_"cl"$ 为下述范畴:
  
  1. 对象是 $X$ 的开集.
  2. 态射是开集的包含映射.

  对于每个 $U subset X$, 定义 $"Cov"(U)$ 为所有开覆盖 ${U_i subset U}_i$ 的集合. 显然 $X_"cl"$ 是一个景, 称之为*拓扑空间的景* (topological site).
]

#example(title:[整体拓扑])[
  取范畴 $Top$, $U$ 是拓扑空间, 那么 $"Cov"(U)$ 定义为全体联合满射的开嵌入 (开连续单射) 族
  $ {U_i->U} $
  联合满射是指其像覆盖了 $U$. 这给出了一个景, 称之为*整体拓扑* (global topology).
]

#example(title:[小étale景])[
  设 $X$ 是概形, 考虑 $Sch\/X$ 的全子范畴 $X_etale$ 定义为:

  1. 对象是所有étale的 $X$-概形 $U->X$.
  2. 态射是 $X$-概形之间的态射.

  对于每个 $U in X_etale$, 定义 $"Cov"(U)$ 为所有联合满射的étale态射族 ${U_i->U}_i$. 显然 $X_etale$ 是一个景, 称之为*小étale景* (small étale site).
]

#remark[
  "小" 的意思是只允许看那些已经 étale 地映到固定 $X$ 的对象; "大" 的意思是允许所有 $X$-概形作为测试对象. 小景更像固定空间上的局部理论, 大景更适合讨论随基变换变化的几何对象.
]

下面的景会在定义概形的时候用到: 

#example(title:[仿射大Zariski景])[
  取范畴 $Aff$, 对于每个 $Spec A$, 取覆盖族为全体
  $ {D(f_i) = Spec A_(f_i) -> Spec A}_(i in I) $
  满足 $union_i D(f_i) = Spec A$. 有限覆盖时等价于 $(f_1,...,f_n)=A$. 记作 $Aff_"Zar"$.
]

#example(title:[大Zariski景])[
  取范畴 $Sch$, 对于每个 $X in Sch$, 取覆盖族为全体联合满射的开嵌入族 ${U_i->X}_i$. 记作 $Sch_"Zar"$.
]

#definition(title:[fppf景])[
  取范畴 $Sch\/S$, 对象 $X->S$ 的覆盖族指定为全体 $S$-态射
  $ {f_i:U_i->X}_i $
  满足每个 $f_i$ 都是平坦且局部有限表示的, 并且联合满射. 称之为*fppf景* (fppf site), 记作 $Sch\/S_"fppf"$.
]
术语 "fppf" 来自法语 "fidèlement plat et de présentation finie".

== fpqc景

#lemma[
  设 $f:X->Y$ 是满的概形态射, 则下列条件等价:

  1. $Y$ 的每个拟紧开子集都是 $X$ 中某个拟紧开子集的像.
  2. 存在 $Y$ 的一个仿射开覆盖 ${V_i}_i$ 使得每个 $V_i$ 是 $X$ 中某个拟紧开子集的像.
  3. 对任意 $x in X$, 存在 $x$ 的一个开邻域 $U subset X$ 使得 $f(U)$ 在 $Y$ 中是开集, 且限制态射 $U->f(U)$ 拟紧.
  4. 对任意 $x in X$, 存在 $x$ 的一个拟紧开邻域 $U subset X$ 使得 $f(U)$ 在 $Y$ 中是仿射开集.
] <lemma-fpqc>

#definition(title:[fpqc态射])[
  一个*fpqc态射* (fpqc morphism) 是一个忠实平坦态射, 且满足 @lemma-fpqc 中的任一等价条件.
]

所谓 "fpqc" 来自法语 "fidèlement plat et quasi-compact". 也就是忠实平坦且拟紧致.

#remark[
  这里的 "拟紧" 不是说 $X$ 本身拟紧, 而是说态射 $X->Y$ 在覆盖意义下能由拟紧开集控制. 这点很重要: fpqc 态射允许非常大的源空间, 但要求它局部上仍然能用拟紧片段压住, 否则下降时会出现集合论和粘合上的麻烦.
]

#theorem[
  fpqc态射的复合是fpqc的.
]

#proof[
  忠实平坦性对复合封闭. 只需看拟紧条件. 若
  $ X ->^f Y ->^g Z $
  都是 fpqc, 给定 $Z$ 的拟紧开子集 $W$, 先由 $g$ 的 fpqc 条件找到 $Y$ 中拟紧开 $V$ 使得 $g(V)=W$; 再由 $f$ 的 fpqc 条件找到 $X$ 中拟紧开 $U$ 使得 $f(U)=V$. 于是 $(g f)(U)=W$, 得到复合的 fpqc 条件.
]

#theorem[
  fpqc态射的基变换是fpqc的.
]

#proof[
  平坦性、满性和拟紧性都对基变换稳定. 更具体地, 若 $X->Y$ 是 fpqc, 对任意 $Y'->Y$, 纤维积
  $ X times_Y Y' -> Y' $
  仍然平坦且满. 对 $Y'$ 的拟紧开集, 可在 $Y$ 的仿射开覆盖上局部检查, 再把 @lemma-fpqc 的拟紧开提升条件拉回即可. 所以基变换仍为 fpqc.
]

#theorem[
  若 $f:X->Y$ 是态射, 存在 $Y$ 的开覆盖 ${V_i}$ 使得限制 $f^(-1)(V_i)->V_i$ 是fpqc的, 则 $f$ 是fpqc的.
]

#proof[
  平坦性、满性都是目标 Zariski 局部性质, 所以可由每个 $V_i$ 上的结论推出. @lemma-fpqc 中的拟紧开提升条件也可在 $Y$ 的开覆盖上检查: 给定 $Y$ 中的拟紧开 $W$, 先用有限多个 $W inter V_i$ 覆盖它, 分别从 $f^(-1)(V_i)$ 中取拟紧开提升, 再取有限并即可.
]

#theorem[
  开的忠实平坦态射是fpqc的.
]

#theorem[
  局部有限表示的忠实平坦态射是fpqc的.
]

#proof[
  对第一条, 若 $f:X->Y$ 是开的且忠实平坦, 则对每个 $x in X$ 可取拟紧开邻域 $U$; 因为 $f$ 开, $f(U)$ 是开集, 而限制 $U->f(U)$ 拟紧, 所以满足 @lemma-fpqc 的条件.

  对第二条, 局部有限表示态射是局部拟呈示的, 特别地在源和目标的仿射开上由有限生成代数给出, 因而局部拟紧. 忠实平坦给出满和平坦, 局部拟紧给出 @lemma-fpqc 所需的拟紧控制, 所以是 fpqc.
]

#theorem[
  若 $f:X->Y$ 是fpqc的, 一个 $Y$ 的子集 $U$ 是开的当且仅当 $f^(-1)(U)$ 是开的.
]

#remark[
  这个结论非常有用: 对 fpqc 覆盖而言, 拓扑空间上的开性可以下降. 很多几何性质的 fpqc 下降都先从这类拓扑事实开始, 然后再处理结构层或模层上的代数数据.
]

#definition(title:[fpqc景])[
  取范畴 $Sch\/S$, 对象 $X->S$ 的覆盖族指定为全体 $S$-态射
  $ {U_i->U}_i $
  使得诱导的态射
  $ union.sq.big_i U_i -> U $
  是fpqc的. 称之为*fpqc景* (fpqc site), 记作 $Sch\/S_"fpqc"$.
]

我们定义了四种常用的景, 它们的精细程度从粗糙到精细依次为 Zariski, étale, fppf, fpqc. 也就是说, 每个 Zariski 覆盖都是 étale 覆盖, 每个 étale 覆盖都是 fppf 覆盖, 每个 fppf 覆盖都是 fpqc 覆盖. 所以拓扑越精细, 需要满足的层条件越强.

#example[
  一个典型的 fpqc 覆盖是忠实平坦的仿射态射
  $ Spec B -> Spec A $
  其中 $A->B$ 忠实平坦. 它未必是局部有限表示的, 因此一般不一定是 fppf 覆盖. 这正是 fpqc 拓扑比 fppf 拓扑更细的地方.
]

#theorem[
  设 $X->Y$ 是概形态射, ${Y_i->Y}_i$ 是fpqc覆盖, 若对每个 $i$, $Y_i times_Y X->Y_i$ 满足:

  1. 是分离态射.
  2. 是拟紧态射.
  3. 是局部有限表示态射.
  4. 是紧合态射.
  5. 是仿射态射.
  6. 是有限态射.
  7. 是平坦态射.
  8. 是光滑态射.
  9. 是非分歧态射.
  10. 是平展态射.
  11. 是嵌入.
  12. 是闭嵌入.

  则 $X->Y$ 亦然.
]

#remark[
  这个定理的读法是: 上述性质可以在 fpqc 覆盖后检查. 例如要证明 $X->Y$ 是平坦的, 可以先找一个 fpqc 覆盖 $Y'->Y$, 证明基变换 $X times_Y Y'->Y'$ 平坦, 再下降回来. 这类命题是下降理论真正好用的地方.
]

#example[
  若 $A->B$ 忠实平坦, 且 $M$ 是 $A$-模, 那么
  $ M=0 $
  当且仅当
  $ B times.o_A M=0 $
  这就是最基础的 fpqc 检查思想: 一个模是否为零可以在忠实平坦基变换后判断. 几何上对应的是拟凝聚层是否为零可在 fpqc 覆盖后检查.
]

== 景上的层

#let pr = $"pr"$

#remark[
  本书中, 我们使用记号
  $ pr_i:X times ... times X->X $
  表示第 $i$ 个投影. 类似地
  $ pr_(i_1...i_r) : X times ... times X -> X times ... times X $
  表示在第 $i_1,...,i_r$ 个位置上的投影.
]

若 $X$ 是拓扑空间, $X$ 上集合值的一个层是指一个函子
$ X_"cl"^op -> Set $
并且满足一些层公理. 这些可以非常轻易地推广到任何景上.

#definition(title:[分离性])[
  设 $C$ 是一个景, 预层 $F:C^op->Set$ 若满足对任意覆盖族
  $ {u_i->u}_i $
  以及任意两个截面 $a,b in F(u)$, 只要他们在每个 $u_i$ 上的拉回相同 $f^*_i a = f^*_i b$, 就能推出 $a=b$, 此时称 $F$ 是*分离的* (separated).
]

#remark[
  因为 $F$ 是反变函子 $C^op -> Set$, 所以每个态射 $f_i:u_i->u$ 都诱导映射
  $ f^*_i := F(f_i):F(u) -> F(u_i) $
  称之为拉回, 也就是我们常说的截面在开集上的限制.
]

#definition(title:[层])[
  设 $C$ 是一个景, 预层 $F:C^op->Set$ 若满足: 给定 $C$ 中的覆盖 ${u_i->u}_i$ 和一系列元素 $a_i in F(u_i)$, 记 $u_i times_u u_j$ 到两个分量 $u_i,u_j$ 上的投影为 $pr_1,pr_2$, 若
  $ pr^*_1 a_i = pr^*_2 a_j in F(u_i times_u u_j) $
  对所有 $i,j$ 成立, 则存在唯一的 $a in F(u)$ 使得 $f^*_i a = a_i$ 对所有 $i$ 成立. 此时称 $F$ 是一个*层* (sheaf).
]

层显然是分离的. 我们可以用显然的方式来定义群的层, 环的层, 模的层, etc. 上述条件显然涵盖了经典的层公理.

#remark[
  这里的相容性只写在二重交 $u_i times_u u_j$ 上. 不需要额外写三重交, 是因为我们正在粘合的是集合值对象: 一旦候选整体截面存在且唯一, 三重交上的一致性会自动跟着二重交条件走. 以后粘合范畴中的对象时, 三重交会以 cocycle 条件的形式重新出现, 那就不是装饰了.
]

我们可以用另一个角度来解释层公理, 考虑 $F:C^op -> Set$ 和覆盖 ${u_i->u}_i$, 有图表
$ F(u) -> product_i F(u_i) arrows^(pr^*_1)_(pr^*_2) product_(i,j) F(u_i times_u u_j) $
第一个箭头由限制 $F(u)->F(u_i)$ 诱导, 而
$ pr^*_1:product_i F(u_i) -> product_(i,j) F(u_i times_u u_j) $
将 $(a_i)_i in product_i F(u_i)$ 送到 $(pr^*_1 a_i)_i,j in product_(i,j) F(u_i times_u u_j)$, 类似地定义 $pr^*_2$. 那么预层 $F$ 是分离的当且仅当第一个箭头是单射, 而 $F$ 是层当且仅当第一个箭头是等化子.

== 筛 (sieve)

=== 筛的引入

#definition(title:[子函子])[
  一个函子 $F:C->Set$ 的*子函子* (subfunctor), 是一个函子
  $ G:C->Set $
  以及一个自然变换 $i:G arrow.hook F$ 使得每个对象 $u in C$,
  $ i_u:G(u) arrow.hook F(u) $
  是单射. 换句话说, 子函子就是函子范畴的子对象.
]

我们引入筛的概念, 是为了将 "覆盖一个对象" 这个概念从一族态射提升成与所有进一步拉回自动兼容的局部信息. 例如对于拓扑空间 $X$, 固定 $U subset X$, 并取一个覆盖
$ U = union.big_(i in I)U_i $
现在考虑所有包含态射 $V arrow.hook U$, 使得 $V subset U_i$ 对某个 $i$ 成立, 这些态射的集合称之为 $U$ 的一个*筛* (sieve) $R$. 显然 $R$ 有关键性质
$ V in R, quad W subset V ==> W in R $
在 $X_"cl"$ 中, 态射就是包含映射, 这个筛可写为
$ 
R(V) = cases(
  {*} quad & V subset U_i "对某个" i,
  nothing quad & "其余情况"
)
$
它是可表函子 $h_U=Hom(-,U)$ 的子函子. 更一般地, 给定范畴 $C$ 的对象 $u$, 以及一族指向 $u$ 的态射
$ frak(u)={u_i->u}_i $
定义一个函子 $h_frak(u) subset h_u$ 为: 对任何对象 $t$, $h_frak(u)(t)$ 为全体满足下述条件的态射 $t->u$ 组成的集合: 存在某个 $u_i$ 使得 $t->u$ 可以分解为 $t->u_i->u$. 此时我们称 $h_frak(u)$ 是与覆盖 $frak(u)$ 相联系的*筛*. 更一般地, 我们有如下定义:

=== 筛的定义

#definition(title:[筛])[
  设 $u$ 是 $C$ 的一个对象, $u$ 上的一个*筛* (sieve) 是可表函子
  $ h_u:C^op -> Set $
  的一个子函子.
]

给定一个筛 $S subset h_u$, 我们便得到了一族指向 $u$ 的态射 $t->u$, 由所有集合 $S(t)$ 的并组成, 其中 $t$ 跑遍所有 $C$ 的对象. 只要一个态射 $t->u$ 属于 $S$, 那么对于任何 $t'->t$, 复合 $t'->t->u$ 也属于 $S$.

反之, 任何满足上述条件的态射族都能得到一个函子 $S subset h_u$, 其中 $S(t)$ 定义为该态射族中所有从 $t->u$ 的态射组成的集合.

现在, 设 $frak(u) = {u_i->u}_i$ 是态射族, $F:C^op->Set$ 是函子, 定义 $F(frak(u))$ 为所有元素 $s_i in F(u_i)$ 的集合, 这些元素满足他们在 $F(u_i times_u u_j)$ 中的像彼此相等. 于是限制映射 $F(u)->F(u_i)$ 诱导出了映射
$ F(u) --> F(frak(u)) $
也就是说, $F(frak(u))$ 就是 "$frak(u)$ 意义下的相容局部截面族" 的集合. 显然一个层就是函子 $F:C^op->Set$, 使得对于每个覆盖 $frak(u)={u_i->u}_i$, 映射 $F(u)->F(frak(u))$ 是双射.

而集合 $F(frak(u))$ 可以由筛的语言描述:

#theorem[
  存在一个典范双射
  $ r:Hom(h_frak(u),F) -->^~ F(frak(u)) $
  使得下图交换
  #align(center, diagram({
	node((1, 0), [$Hom(h_u,F)$])
	node((2, 0), [$F(u)$])
	node((2, 1), [$F(frak(u))$])
	node((1, 1), [$Hom(h_frak(u),F)$])
	edge((1, 1), (2, 1), [$r$], label-side: right, "->")
	edge((1, 0), (2, 0), "->")
	edge((2, 0), (2, 1), "->")
	edge((1, 0), (1, 1), "->")
  }))
  上面的态射是Yoneda同构, 左边是嵌入 $h_frak(u) arrow.hook h_u$ 诱导的限制, 右边是限制映射 $F(u)->F(u_i)$ 诱导的.
]

#proof[
  先取一个自然变换 $phi:h_frak(u)->F$. 对每个 $i$, 态射 $u_i->u$ 是集合 $h_frak(u)(u_i)$ 的一个元素, 因此我们得到一个元素
  $ r phi := (phi(u_i->u)) in product_i F(u_i) $
  在 $u_(i j)=u_i times_u u_j$ 上, 元素
  $ pr^*_1 phi(u_i -> u), quad pr^*_2 phi(u_j -> u) $
  都等于 $phi(u_(i j)->u)$. 因此 $r phi$ 实际上属于 $F(frak(u))$, 这定义了映射
  $ r:Hom(h_frak(u),F) --> F(frak(u)) $
  下面证明其为双射即可.

  取两个自然变换
  $ phi,psi : h_frak(u) -> F $
  并假设 $r phi = r psi$. 考虑某个 $h_frak(u)(t)$ 中的元素, 也就是一个态射
  $ t->u $
  根据 $h_frak(u)$ 的定义, 他可以过某个 $u_i$ 分解
  $ t -->^f u_i -->u $
  由自然变换的定义
  $ phi(t->u) = f^*phi(u_i->u) = f^*psi(u_i->u) = psi(t->u) $
  因此 $phi=psi$. 这说明 $r$ 是单射.

  取一个相容族 $(xi_i) in F(frak(u))$, 我们需要定义一个自然变换
  $ phi : h_frak(u) -> F $
  设 $t->u$ 是 $h_frak(u)(t)$ 的一个元素, 选择一个分解
  $ t-->^f u_i --> u $
  定义
  $ phi(t->u) := f^* xi_i in F(t) $
  需要验证 $phi$ 的定义与分解的选择无关. 假设我们有两个分解
  $ t-->^f u_i --> u, quad t-->^g u_j -> u $
  由纤维积的泛性质, 得到态射
  $ t -> u_(i j) = u_i times_u u_j $
  使得其与投影
  $ pr_1: u_(i j) -> u_i, quad pr_2: u_(i j) -> u_j $
  复合后分别得到 $f$ 和 $g$. 由相容性条件
  $ pr^*_1 xi_i = pr^*_2 xi_j $
  因此 $f^* xi_i = g^* xi_j$, 这说明 $phi$ 的定义与分解的选择无关. 这样对每个 $t$ 定义了映射
  $ h_frak(u)(t) -> F(t) $
  显然构成一个自然变换
  $ phi : h_frak(u) -> F $
  并且 $r phi = (xi_i)_i$. 这说明 $r$ 是满射.
]

于是我们又得到层的一种刻画:

#corollary[
  一个预层 $F:C^op->Set$ 是层当且仅当对 $C$ 中的任意一个覆盖
  $ frak(u) = {u_i->u} $
  诱导的映射
  $ Hom(h_u,F) --> Hom(h_frak(u),F) $
  都是双射. $F$ 是分离的当且仅当这些映射都是单射.
]

=== 与Grothendieck拓扑

#definition(title:[覆盖筛])[
  设 $cal(T)$ 是范畴 $C$ 上的 Grothendieck 拓扑, 称对象 $u in C$ 上的一个筛 $S subset h_u$ 是*覆盖筛* (covering sieve), 当且仅当存在一个覆盖族 ${u_i->u}_i in cal(T)$ 使得 $h_frak(u) subset S$.
]

若 $C$ 是一个景, 我们所说的 $C$ 上的筛就是指 $C$ 上的 Grothendieck 拓扑所定义的覆盖筛.

#theorem[
  设 $F:C^op->Set$ 是一个预层, 则 $F$ 关于拓扑 $cal(T)$ 是层当且仅当对每个 $cal(T)$ 的覆盖筛 $S subset h_u$, 诱导的映射
  $ Hom(h_u,F) --> Hom(S,F) $
  都是双射, 进一步 $F$ 是分离的当且仅当这些映射都是单射.
]

最后我们作一个说明, 设
$ frak(u) = {u_i->u}, quad frak(v) = {v_j->u} $
都是覆盖, 定义
$ frak(u) times_u frak(v) := {u_i times_u v_j -> u} $
那么这仍然是 $u$ 的一个覆盖, 并且一个态射 $t->u$ 能够经某个 $u_i times_u v_j$ 分解, 当且仅当它能经某个 $u_i$ 分解并且能经某个 $v_j$ 分解. 于是我们有

#theorem[
  若
  $ frak(u) = {u_i->u}, quad frak(v) = {v_j->u} $
  都是覆盖, 则
  $ h_(frak(u)times_u frak(v)) = h_frak(u) inter h_frak(v) subset h_u $
]

#theorem[
  若 $S_1,S_2$ 是 $u$ 上属于拓扑 $cal(T)$ 的两个覆盖筛, 那么其交
  $ S_1 inter S_2 subset h_u $
  也是 $cal(T)$ 的覆盖筛.
]

也就是说, 两个覆盖筛的交恰好是共同细化覆盖的覆盖筛. 并且覆盖筛对有限交封闭.

#remark[
  筛的好处是它自动记住所有进一步拉回. 覆盖族像是一组生成元, 覆盖筛则像由这些生成元闭包出来的理想. 因此很多关于覆盖的陈述, 用筛说会更不依赖具体选择.
]

== Grothendieck拓扑的等价性

=== 加细

#definition(title:[加细])[
  设 $C$ 是一个范畴, 给定一族态射 ${u_i->u}_i$, 称另外一族 ${v_a->u}_a$ 是它的*加细* (refinement), 是指对于每个 $a$, 都存在某个 $i$, 使得态射 $v_a->u$ 可以经由 $u_i->u$ 分解:
  $ v_a --> u_i -->u $
  具体的分解并不是数据的一部分, 我们只要求这样的分解存在.
]

这一关系用覆盖筛最容易表达:

#theorem[
  设两族指向 $u$ 的态射
  $ frak(u) = {u_i->u}, quad frak(v) = {v_a->u} $
  则 $frak(v)$ 是 $frak(u)$ 的加细, 当且仅当 $h_frak(v) subset h_frak(u)$.
]

一个加细的加细显然是加细, 任何覆盖都是自身的加细. 所以在 $u$ 的全体覆盖组成的集合上 "是...的加细" 构成偏序关系.

#example[
  在拓扑空间 $X$ 的开集范畴里, 覆盖
  $ U = U_1 union U_2 $
  的一个加细可以是
  $ U = V_1 union V_2 union V_3 $
  其中每个 $V_a$ 都包含在某个 $U_i$ 中. 注意我们不要求 $V_a$ 属于哪一个 $U_i$ 的选择唯一; 加细只记录 "局部片段变得更小了". 这和分析里把开覆盖细分成更小开集是同一件事.
]

=== Grothendieck拓扑的等价

#definition(title:[Grothendieck拓扑的等价])[
  设 $C$ 是一个范畴, $cal(T)$ 和 $cal(T)'$ 是 $C$ 上的两个Grothendieck拓扑, 若 $cal(T)$ 中的每个覆盖都存在 $cal(T)'$ 中的覆盖是其加细, 则称 $cal(T)$ *从属* (subordinate) 于 $cal(T)'$, 记作 $cal(T) prec cal(T)'$. 若 $cal(T) prec cal(T)'$ 且 $cal(T)' prec cal(T)$, 则称 $cal(T)$ 和 $cal(T)'$ *等价* (equivalent).
]

#theorem[
  设 $cal(T)$ 和 $cal(T)'$ 是范畴 $C$ 上的两个Grothendieck拓扑, 则
  $ cal(T) prec cal(T)' $
  当且仅当每个 $cal(T)$ 的覆盖筛也是 $cal(T)'$ 的覆盖筛.
]

特别地两个拓扑等价当且仅当具有完全一致的覆盖筛.

#theorem[
  设 $cal(T)$ 和 $cal(T)'$ 是范畴 $C$ 上的两个Grothendieck拓扑, 若
  $ cal(T) prec cal(T)' $
  那么每一个关于 $cal(T)'$ 的层都是关于 $cal(T)$ 的层.
]

#proof[
  设 $F$ 是关于 $cal(T)'$ 的层, 取 $cal(T)$ 中的覆盖 $frak(u)$. 由 $cal(T) prec cal(T)'$, 存在 $cal(T)'$ 中的覆盖 $frak(v)$ 加细 $frak(u)$. 若 $F$ 的截面族在 $frak(u)$ 上相容, 拉回到更细的 $frak(v)$ 后当然相容, 因而由 $cal(T)'$-层条件唯一粘合成 $u$ 上的截面. 唯一性也可在 $frak(v)$ 上检查. 所以 $F$ 满足 $cal(T)$ 的层条件.
]

按照Grothendieck拓扑的术语, 这里我们所定义的对象应该称为一个*预拓扑* (pretopology), 两个等价的预拓扑定义同一个拓扑.

#example[
  在 $Sch\/S$ 上, 由联合满射的局部有限表示的光滑态射定义的预拓扑, 即*光滑拓扑*与平展拓扑是等价的.
]

=== 饱和拓扑

#definition(title:[饱和拓扑])[
  设 $cal(T)$ 是范畴 $C$ 上的拓扑, 若一族态射
  $ {u_i->u}_i $
  只要存在一个属于 $cal(T)$ 的加细, 就必然属于 $cal(T)$. 则称 $cal(T)$ 是*饱和的* (saturated). 对任何拓扑我们可以用显然的方式定义*饱和化* (saturation) $overline(cal(T))$ 为全体在 $cal(T)$ 中有加细的覆盖.
]

#theorem[饱和化是饱和拓扑.]
#theorem[$cal(T) prec overline(cal(T))$.]
#theorem[$cal(T)$ 与 $overline(cal(T))$ 等价.]
#theorem[拓扑是饱和的当且仅当 $cal(T)=overline(cal(T))$.]
#theorem[$cal(T)' prec cal(T)$ 当且仅当 $cal(T)' subset overline(cal(T))$.]
#theorem[$cal(T)'$ 与 $cal(T)$ 等价当且仅当 $overline(cal(T)')=overline(cal(T))$.]
#theorem[等价的拓扑共享同一个饱和拓扑.]

#proof[
  我们只解释其中最核心的几条. 饱和化 $overline(cal(T))$ 的覆盖按定义就是那些有 $cal(T)$-覆盖加细的态射族. 若一个覆盖又被进一步加细, 那么这个更细覆盖仍然有同一个 $cal(T)$-覆盖作为间接加细, 所以饱和化对加细封闭, 即它是饱和的.

  显然每个 $cal(T)$-覆盖都有自身作为 $cal(T)$-加细, 因而属于 $overline(cal(T))$. 反过来, $overline(cal(T))$ 的每个覆盖按定义都有 $cal(T)$-覆盖加细, 所以二者相互从属, 因此等价. 最后一条只是把 "等价拓扑有相同覆盖筛" 翻译成 "取饱和化后相等".
]

#remark[
  实际使用时, 我们常常随手把一个预拓扑替换成它的饱和化. 这样做不会改变层范畴, 但可以让一些陈述更干净: 只要一个覆盖能被好覆盖细化, 它就自动也是覆盖. 这有点像把 "开覆盖" 视作对加细封闭的概念, 很省心.
]

== 可表函子的层条件

=== 可表函子作为层

#theorem[
  一个可表函子
  $ h_X:Top^op -> Set $
  关于整体经典拓扑是一个层.
]

上述定理等价于说, 给定两个拓扑空间 $U$ 和 $X$, 一个开覆盖
$ {U_i subset U} $
以及连续映射 $f_i:U_i->X$ 并且对所有 $i,j$, $f_i$ 和 $f_j$ 在交集
$ U_i inter U_j $
上的限制相同, 那么存在唯一的连续映射 $f:U->X$, 使得它在每个 $U_i$ 上的限制都是 $f_i$. 这基本上是显然的, 归结为一个事实: 对于函数而言, 连续性是定义域上的局部性质. 类似地也有

#theorem[
  一个可表函子
  $ h_X:(Sch\/S)^op -> Set $
  关于Zariski拓扑是一个层.
]

#proof[
  取 $S$-概形 $U$ 的 Zariski 开覆盖 ${U_i->U}_i$, 以及一族 $S$-态射
  $ f_i:U_i->X $
  若它们在 $U_i inter U_j$ 上相同, 则拓扑空间层面可唯一粘合成连续映射
  $ f:U->X $
  结构层态射也可在开覆盖上粘合, 因为环层态射本身满足层式的局部性. 粘合后的 $(f,f^sharp)$ 是概形态射, 且唯一性同样可在开覆盖上检查. 因而 $h_X$ 满足 Zariski 层条件.
]

而下面的定理则是更深的结果, 先验地说, 没有任何明显的理由说明为什么概形之间的态射可以在比Zariski更精细的拓扑下粘合起来. 这就是Grothendieck的深刻见解.

#theorem(title:[Grothendieck])[
  一个可表函子
  $ h_X:(Sch\/S)^op -> Set $
  关于fpqc拓扑是一个层.
] <thm-grothendieck-sheaf>

推论可得, 其关于étale拓扑, fppf拓扑, Zariski拓扑都是层. 我们称一个态射 $v->u$ 为*有效满态射* (effective epimorphism), 当且仅当对 $C$ 的任何对象 $x$, 每个态射
$ a:v->x $
只要其沿两个投影
$ v times_u v arrows^(pr_1)_(pr_2) v ->^a x $
所得的两个复合相同, 那么 $a$ 就能唯一经由 $u$ 分解. 换句话说, 我们要求
$ Hom_C (u,x) -> Hom_C (v,x) arrows Hom_C (v times_u v,x) $
是等化子图表. 上述定理表明, 每个概形的fpqc态射在 $Sch\/S$ 中都是有效满态射.

#remark[
  这句话的几何含义是: 如果两个从 $v$ 出发的态射在 $v times_u v$ 上一致, 那么它们确实来自 $u$. 换句话说, 对概形态射来说, fpqc 覆盖足够细, 但又没有细到破坏粘合. 这是 fpqc 下降理论能够成立的根源之一.
]

#example[
  设 $A->B$ 是忠实平坦环同态. 若两个 $A$-代数同态
  $ R -> A $
  在张量到 $B$ 后相同, 则它们本来就相同. 这是因为 $A->B$ 忠实平坦, 映射
  $ A -> B $
  在等化意义下能检测元素相等. 这就是仿射情形中 "可表函子是 fpqc 分离的" 的影子.
]

=== 次典范拓扑

#definition(title:[次典范拓扑])[
  设 $cal(T)$ 是范畴 $C$ 上的拓扑, 若 $C$ 上的每个可表函子关于 $cal(T)$ 都是层, 则称 $cal(T)$ 是*次典范* (subcanonical) 的. 一个次典范景就是赋予了次典范拓扑的范畴.
]

在任何范畴上都存在一个使得所有可表函子都是层的最细的拓扑, 称之为*典范拓扑* (canonical topology), 但这里我们不会用到这个事实.

#example[
  Zariski, étale, fppf, fpqc 拓扑在概形范畴上都是次典范的. 这并不是一句空话: 它保证了我们把概形 $X$ 看作函子
  $ h_X:(Sch\/S)^op -> Set $
  时, 不会丢失通常的粘合性质. 因此 "概形是某种层" 这句话可以严肃地使用.
]

#remark[
  次典范性常被用来默默识别对象与可表层. 例如当我们说一个层 $F$ 被概形 $X$ 表示时, 实际意思是 $F$ 与 $h_X$ 同构. 若拓扑不是次典范的, 可表预层不一定是层, 这句话就会变得别扭.
]

== 预层的层化

#definition(title:[层化])[
  设 $C$ 是一个景, $F:C^op->Set$ 是一个预层, 则 $F$ 的一个*层化* (sheafification) 是一个层
  $ F^a:C^op->Set $
  连同一个自然变换 $F=>F^a$, 满足:

  1. 给定 $C$ 中的对象 $u$, 以及两个元素 $xi,eta in F(u)$, 若他们在 $F^a (u)$ 中的像 $xi^a,eta^a$ 相同, 则存在一个覆盖 ${sigma_i:u_i->u}$ 使得 $sigma^*_i xi = sigma^*_i eta$ 对所有 $i$ 成立.
  2. 对每个对象 $u$ 以及元素 $overline(xi) in F^a (u)$, 存在一个覆盖 ${sigma_i:u_i->u}$ 和元素 $xi_i in F(u_i)$, 使得 $xi^a_i=sigma^*_i overline(xi)$.
]

第一条曰: 两个原预层中的截面若在层化后相等, 那么他们局部已经相等.

第二条曰: 层化中的每个截面, 局部都来自原预层中的截面.

关于层化, 下面的性质是基础且重要的, 但是我懒得写证明了\_(:з」∠)\_, 下设 $C$ 是景且 $F:C^op->Set$ 是预层.

#theorem(title:[层化的泛性质])[
  若 $F^a:C^op->Set$ 是 $F$ 的一个层化, 那么 $F$ 到任意层的态射都过 $F^a$ 唯一分解.
]

#proof[
  设 $G$ 是层, 并给定预层态射 $phi:F->G$. 若 $overline(xi) in F^a(u)$, 按层化定义, 存在覆盖 ${u_i->u}_i$ 使得 $overline(xi)|_(u_i)$ 来自某个 $xi_i in F(u_i)$. 我们想定义
  $ phi^a(overline(xi))|_(u_i) := phi(xi_i) $
  需要检查这与选择无关. 若换了局部代表, 两个代表在进一步覆盖后相等; 由于 $G$ 是分离的, 它们在 $G(u_i)$ 中的像相同. 相容性同理在覆盖上检查, 然后用 $G$ 的层条件粘合出唯一的 $phi^a(overline(xi)) in G(u)$. 唯一性来自 $F^a$ 的每个截面局部来自 $F$.
]

#theorem[
  层化总是存在且在自然同构意义下唯一.
]

#remark[
  层化可以理解为两步修补: 先把 "局部相等就应该相等" 的截面强制识别掉, 得到分离预层; 再把 "相容局部截面应该能粘起来" 的缺口补上. 所以层化不是随意往预层里塞元素, 而是只加入那些被局部数据逼迫出来的元素.
]

#theorem[
  自然变换 $F->F^a$ 是单射当且仅当 $F$ 分离.
]

#example[
  拓扑空间 $X$ 上的预层
  $ U |-> "连续函数" U -> RR $
  已经是层, 因此层化不改变它. 但若取
  $ U |-> "常值函数" U -> RR $
  在不连通开集上通常不是层: 不同连通分支上可以取不同常数, 它们局部看起来都常值, 但整体不一定是单个常数. 它的层化就是局部常值函数层.
]

#example[
  在概形的 Zariski 景上, 预层
  $ U |-> cal(O)_X(U)^* $
  是层, 因为可逆函数可以局部粘合, 且逆元也局部粘合. 但预层
  $ U |-> cal(O)_X(U)\/cal(O)_X(U)^* $
  一般不应天真地期待是层: 先取商再粘合和先粘合再取商未必交换. 处理这类对象时, 常常要写成预层商后再层化.
]

= 纤维范畴

在基础的代数几何中, 我们就已经接触过了一些 "带有基底的对象". 例如我们常说 "概形 $X$ 上的向量丛", "环 $A$ 上的模" 等等. 纤维范畴就是具体刻画这种关系的装置, 将这些相对信息并为一个总范畴.

#remark[
  一个很好的读法是: 基范畴 $C$ 负责记录 "在哪个空间上", 总范畴 $F$ 负责记录 "空间上带了什么东西". 投影 $p_F:F->C$ 则把附加结构忘掉. 纤维范畴公理要求这些附加结构能沿基底态射拉回.
]

== 纤维范畴的定义

=== Cartesian态射

本章中, 我们会固定一个范畴 $C$, 我们研究的对象是 $C$ 上的范畴, 也就是范畴 $F$ 连同一个函子
$ p_F:F->C $
我们绘画若干个同时包含 $C,F$ 对象的交换图, 从 $F$ 的对象 $xi$ 到 $C$ 的对象 $u$ 的箭头形如 $xi |-> u$, 表示 $p_F xi = u$. 而图表
#align(center, diagram({
	node((0, 0), [$xi$])
	node((0, 1), [$u$])
	node((1, 1), [$v$])
	node((1, 0), [$eta$])
	edge((0, 0), (0, 1), "|->")
	edge((0, 0), (1, 0), [$phi$], label-side: left, "->")
	edge((1, 0), (1, 1), "|->")
	edge((0, 1), (1, 1), [$f$], label-side: right, "->")
}))
交换意味着 $p_F phi=f$.

#definition(title:[Cartesian态射])[
  设 $F$ 是 $C$ 上的范畴, $F$ 的一个态射 $phi:xi->eta$ 称之为*Cartesian态射* (Cartesian morphism), 当且仅当对任意 $F$ 中的态射 $psi:zeta->eta$ 和 $C$ 中的态射 $h:p_F zeta->p_F xi$ 满足
  $ p_F phi compose h = p_F psi $
  那么存在唯一的 $F$ 中的态射 $theta:zeta->xi$ 使得 $p_F theta=h$ 且 $phi compose theta = psi$. 也就是下图
  #align(center, diagram({
	node((0, 0), [$zeta$])
	node((1, 1), [$xi$])
	node((2, 1), [$eta$])
	node((0, 1), [$p_F zeta$])
	node((1, 2), [$p_F xi$])
	node((2, 2), [$p_F eta$])
	edge((0, 0), (1, 1), [$theta$], label-side: right, "-->")
	edge((0, 1), (1, 2), [$h$], label-side: right, "->")
	edge((1, 2), (2, 2), "->")
	edge((1, 1), (2, 1), [$phi$], label-side: right, "->")
	edge((2, 1), (2, 2), "|->")
	edge((1, 1), (1, 2), "|->")
	edge((0, 0), (0, 1), "|->")
	edge((0, 0), (2, 1), [$psi$], label-side: left, "->", bend: 18deg)
	edge((0, 1), (2, 2), "->", bend: 18deg)
  }))
  的实线部分交换, 那么存在唯一的虚线使得整个图交换. 若 $xi->eta$ 是 $F$ 中的Cartesian态射, 并且它打到 $C$ 的态射 $u->v$, 则称 $xi$ 是 $eta$ 到 $u$ 的*拉回* (pullback).
]

#remark[
  设
  $ phi : xi -> eta, quad tilde(phi) : tilde(xi) -> eta $
  都是 $eta$ 到 $u$ 的拉回, 那么唯一态射对应于图表
  #align(center, diagram({
	node((0, 0), [$tilde(xi)$])
	node((1, 1), [$xi$])
	node((2, 1), [$eta$])
	node((0, 1), [$u$])
	node((1, 2), [$u$])
	node((2, 2), [$v$])
	edge((0, 0), (1, 1), [$theta$], label-side: right, "-->")
	edge((0, 1), (1, 2), "=")
	edge((1, 2), (2, 2), "->")
	edge((1, 1), (2, 1), [$phi$], label-side: right, "->")
	edge((2, 1), (2, 2), "|->")
	edge((1, 1), (1, 2), "|->")
	edge((0, 0), (0, 1), "|->")
	edge((0, 0), (2, 1), [$tilde(phi)$], label-side: left, "->", bend: 18deg)
	edge((0, 1), (2, 2), "->", bend: 18deg)
  }))
  显然是同构, 逆映射可以通过切换 $tilde(xi),xi$ 轻易得到. 也就是说, 拉回在 $F$-同构意义下唯一.
]

设范畴 $C$ 有纤维积, 考虑箭头范畴 $"Arr"(C)$ 以及投影函子
$ p:"Arr"(C)->C,quad (x->s)|->s $
给定 $(x->s) in "Arr"(C)$ 和基底态射 $f:t->s$ 形成纤维积
$ x_t := t times_s x $
于是有交换方形
#align(center, diagram({
	node((0, 1), [$t times_s x$])
	node((1, 1), [$x$])
	node((1, 2), [$s$])
	node((0, 2), [$t$])
	edge((0, 1), (1, 1), [$pr_x$], label-side: left, "->")
	edge((1, 1), (1, 2), "->")
	edge((0, 2), (1, 2), [$f$], label-side: right, "->")
	edge((0, 1), (0, 2), "->")
}))
这里 $t times_s x->t$ 是箭头范畴的一个对象, $x->s$ 是另一个对象, 上方投影 $pr_x:t times_s x->x$ 连同底层的 $f:t->s$ 形成一个箭头范畴的态射. 如果有另一个交换图
#align(center, diagram({
	node((1, 1), [$z$])
	node((1, 2), [$r$])
	node((2, 1), [$x$])
	node((2, 2), [$s$])
	edge((1, 1), (2, 1), [$a$], label-side: left, "->")
	edge((2, 1), (2, 2), "->")
	edge((1, 2), (2, 2), [$f compose h$], label-side: right, "->")
	edge((1, 1), (1, 2), "->")
}))
并且给定 $h:r->t$, 那么唯一存在 $z->t times_s x$ 使得整个图分解为
$ (z->r) -> (t times_s x -> t) -> (x->s) $
正是Cartesian态射的定义. 于是我们有箭头范畴中的态射是Cartesian态射当且仅当他是纤维积方形.

#remark[
  因此 Cartesian 态射不是凭空来的概念, 它是在任意 "带基底的对象" 中模拟纤维积方形. 当总范畴真的是箭头范畴时, Cartesian 就是通常意义下的 pullback square.
]

下面几个事实是重要且容易证明的, 下设 $F$ 是 $C$ 上的范畴:

#theorem[
  $F$ 的两个Cartesian态射的复合仍然是Cartesian态射.
]

#theorem[
  设 $xi->eta, eta->zeta$ 是 $F$ 中的两个态射, 若 $eta->zeta$ 是Cartesian态射, 则 $xi->eta$ 是Cartesian态射当且仅当复合 $xi->zeta$ 是Cartesian态射.
]

#theorem[
  若 $F$ 的一个态射在 $C$ 的像是同构, 那么它是Cartesian态射当且仅当它是 $F$ 的同构.
]

#theorem(title:[Cartesian性可沿二重投影传递])[
  设 $p_G:G->C$ 和 $Phi:F->G$ 是函子, 且 $phi:xi->eta$ 是 $F$ 中的箭头, 若 $phi$ 关于他在 $G$ 中的像
  $ Phi phi : Phi xi -> Phi eta $
  是Cartesian的, 且 $Phi phi$ 关于它在 $C$ 中的像
  $ p_G Phi phi : p_G Phi xi -> p_G Phi eta $
  是Cartesian的, 那么 $phi$ 关于它在 $C$ 中的像 $p_G Phi phi$ 也是Cartesian的.
] <thm-cartesian-transitive>

=== 纤维范畴

#definition(title:[纤维范畴])[
  一个位于 $C$ 上的*纤维范畴* (fibered category) 是一个函子
  $ p_F:F->C $
  满足对 $C$ 的任意态射 $f:u->v$ 以及 $F$ 中映到 $v$ 的对象 $eta$, 都存在Cartesian态射 $phi:xi->eta$ 使得 $p_F (phi)=f$.
]

换言之, 纤维范畴就是说, 可以沿着 $C$ 的任何态射拉回 $F$ 中的对象.

#definition(title:[纤维范畴的态射])[
  设 $F,G$ 是 $C$ 上的纤维范畴, 一个函子 $Phi:F->G$ 若满足:

  1. $Phi$ 保持基底, 即 $p_G Phi = p_F$.
  2. $Phi$ 将Cartesian态射映射为Cartesian态射.

  则称 $Phi$ 是 $C$ 上的一个*纤维范畴的态射* (morphism of fibered categories over $C$).
]

注意上述定义中我们要求 $p_G Phi = p_F$ 是严格相等, 而不是自然同构. 这是因为我们希望纤维范畴的态射可以沿着 $C$ 的态射拉回, 而如果只是自然同构, 那么拉回的对象就不唯一了.

#theorem[
  给定函子 $F->G->C$, 若 $F->G$ 和 $G->C$ 都是纤维范畴, 则复合 $F->C$ 也是纤维范畴.
]

=== 纤维与拉回

#definition(title:[纤维])[
  设 $F$ 是 $C$ 上的纤维范畴, 对每个对象 $u in C$, 定义 $F(u)$ 为 $F$ 在 $u$ 处的*纤维* (fiber) 为 $F$ 的一个子范畴:

  1. 其对象是全体满足 $p_F (xi) = u$ 的 $F$ 的对象 $xi$.
  2. 其态射是全体满足 $p_F (phi) = id_u$ 的 $F$ 的态射 $phi$.
]

纤维的概念刻画了 "以 $u$ 为基底的对象" 以及 "在 $u$ 上的态射".

根据定义, 若 $f:F->G$ 是 $C$ 上的纤维范畴的态射, 那么对每个对象 $u in C$, $f$ 把 $F(u)$ 映射到 $G(u)$, 并且保持态射. 也就是说, $f$ 在每个纤维上诱导了一个函子
$ f_u : F(u) -> G(u) $

=== 纤维范畴的例子

#example[
  $"Arr"(C)->C$ 是一个纤维范畴.
]

#example[
  以 $Aff$ 为底范畴, 对于 $u = Spec A$, 令 $F(u)=Mod_A$. 若
  $ f:Spec B->Spec A $
  对应环同态 $A->B$, 拉回为扩张标量
  $ f^*M=B times.o_A M $
  总范畴 $F$ 可以写成全体 $(A,M)$. 态射
  $ (phi,psi):(A,M)->(B,N) $
  为环同态 $phi:A->B$, 以及 $psi:B times.o_A M->N$ 是 $B$-模同态. 记作 $Mod$.
]

#example[
  在 $Sch$ 上, 令 $F(X)=QCoh(X)$ 是一个纤维范畴.
]

#example[
  固定一个景 $C$, 对每个对象 $u$, 令 $F(u)=Sh(C_(\/u))$ 也是一个纤维范畴.
]

#definition(title:[稳定态射])[
  设 $C$ 是范畴, 一个态射类 $S$ 称之为*稳定* (stable), 当且仅当:

  1. $S$ 关于同构封闭, 即 $S$ 中的态射前后复合同构都依然在 $S$ 中.
  2. $S$ 关于基变换稳定, 即若 $f:u->v$ 在 $S$ 中, 且 $g:w->v$ 是任意态射, 则 $u times_v w -> w$ 也在 $S$ 中.
]

#example[
  设 $P$ 是 $C$ 的一类稳定态射, 将属于 $P$ 的所有态射看作一个范畴的对象, 其态射
$ (u->u') -> (v->v') $
  是交换图表
#align(center, diagram({
    node((0, 0), [$u$])
    node((1, 0), [$v$])
    node((0, 1), [$u'$])
    node((1, 1), [$v'$])
    edge((0, 0), (1, 0), label-side: left, "->")
    edge((0, 0), (0, 1), label-side: right, "->")
    edge((1, 0), (1, 1), label-side: left, "->")
    edge((0, 1), (1, 1), label-side: right, "->")
  }))
  容易验证这确实是一个范畴, Cartesian态射正是纤维积方形, 于是我们得到了一个纤维范畴
  $ p_P : P -> C $
  典型的例子有: 平展态射, 平坦态射, 有限态射等.
]

== 伪函子

#remark[
  在 $oo$-范畴论中, 下面两节的结论由 straightening-unstraightening 对应
  $ Fun(C^op,Cat_oo) tilde.eq "CartFib"(C) $
  给出.
]

=== 拉回与拉回选择 (cleavage)

#definition(title:[拉回函子])[
  设 $F$ 是 $C$ 上的纤维范畴, 设 $f:u->v$ 是 $C$ 的一个态射, 对 $v$ 上的对象 $eta$ 取到 $u$ 的拉回
  $ phi_eta : f^* eta -> eta $
  我们定义一个函子 $f^* : F(v) -> F(u)$ 为:

  1. 对每个对象 $eta in F(v)$, 定义 $eta |-> f^* eta$.
  2. 对每个态射 $beta : eta -> eta'$,令 $f^* beta:f^*eta->f^*eta'$ 是使得下图表交换的唯一态射
  #align(center, diagram({
	node((-1, -1), [$f^*eta$])
	node((0, -1), [$eta$])
	node((0, 0), [$eta'$])
	node((-1, 0), [$f^*eta'$])
	edge((-1, 0), (0, 0), "->")
	edge((-1, -1), (0, -1), "->")
	edge((0, -1), (0, 0), [$beta$], label-side: left, "->")
	edge((-1, -1), (-1, 0), [$f^*beta$], label-side: right, "-->")
  }))
  
  唯一性来自下方箭头的Cartesian性. 称函子 $f^*$ 为 $f$ 的*拉回函子* (pullback functor).
]

*注意!* 上述定义还不是特别完整, 因为我们在指定 $f^*eta$ 时, 并没有定义拉回的选择, 因为拉回通常只在同构的意义下唯一, 于是我们需要下面的概念:

#definition(title:[拉回选择])[
  设 $F->C$ 是纤维范畴. 一个*拉回选择* (cleavage) $K$ 是 $F$ 的一类Cartesian态射, 满足对 $C$ 的每个态射 $f:u->v$, 以及每个对象 $eta in F(v)$, 都存在唯一一条 $K$ 中的态射, 终点为 $eta$ 且在 $C$ 中的像为 $f$.
]

也就是说, 一个拉回选择就是在每个对象 $eta$ 上为每个态射 $f$ 选择一个具体的拉回. 

#example[
  对 $QCoh$ 来说, 给定 $f:U->V$ 和 $cal(F) in QCoh(V)$, 我们可以选择
  $ f^*cal(F)=cal(O)_U times.o_(f^(-1)cal(O)_V) f^(-1)cal(F) $
  作为具体拉回. 但对复合 $U->V->W$, 这个表达式与一次性沿复合拉回通常只典范同构, 不会字面相等. 这就是伪函子不可避免的地方.
]

在适当的大小选择下, "每个纤维范畴存在拉回选择" 与选择公理 (AC) 是等价的. 我们上面给出的 "拉回函子" 的定义, 很容易让人误解为我们已经定义了一个函子. 但这并不完全正确, 首先恒等箭头的拉回
$ id^*_u : F(u) -> F(u) $
就未必是恒等函子, 一个更严重的问题如下: 设在 $C$ 中有
$ f: u->v, quad g: v->w $
并设 $zeta in F(w)$, 那么
$ f^*g^*zeta $
是 $zeta$ 到 $u$ 上的拉回, 但我们没有理由要求 $f^*g^*zeta$ 和 $(g f)^* zeta$ 字面相同. 不过因为二者都是 $zeta$ 到 $u$ 上的拉回, 所以他们是同构的. 选择了一个拉回选择后, 我们几乎得到了一个 $C$ 到 $Cat$ 的函子, 但依然不是完全严格的函子. 关键在于, $Cat$ 是一个 $2$-范畴, 两个函子之间还形成一个范畴, $2$-箭头是自然变换. 于是一个带拉回选择的纤维范畴给出的不是严格函子 $C^op->Cat$, 而是下面的伪函子的概念.

=== 伪函子

#definition(title:[伪函子])[
  定义在 $C$ 上的一个*伪函子* (pseudo-functor) $Phi$ 由下列数据组成:

  1. 对 $C$ 的每个对象 $u$, 指定一个范畴 $Phi(u)$.
  2. 对 $C$ 的每个箭头 $f:u->v$, 给定一个函子 $f^*:Phi(v)->Phi(u)$.
  3. 对 $C$ 的每个对象 $u$ 给定函子同构 $epsilon_u:id^*_u =>^~ id_(Phi(u))$, 两边都是 $Phi(u)$ 到 $Phi(u)$ 的函子.
  4. 每一对可复合的 $u->^f v->^g w$, 给定函子同构 $alpha_(f,g):f^*g^*=>^~(g f)^*$.
  
  满足以下条件:

  1. (单位相容) 若 $f:u->v$ 是 $C$ 的态射, 且 $eta in Phi(v)$, 则有
  $
  alpha_(id_u,f)(eta) = epsilon_u (f^*eta) : id^*_u f^* eta -> f^* eta \
  alpha_(f,id_v)(eta) = f^*epsilon_v (eta) : f^* id^*_v eta -> f^* eta
  $
  2. (结合相容) 给定可复合 $u->^f v->^g w->^h t$ 以及对象 $theta in Phi(t)$, 下图表交换:
  #align(center, diagram({
	node((-1, -1), [$f^*g^*h^*theta$])
	node((-1, 0), [$f^*(h g)^*theta$])
	node((0, 0), [$(h g f)^* theta$])
	node((0, -1), [$(g f)^* h^* theta$])
	edge((-1, -1), (0, -1), [$alpha_(f,g)(h^*theta)$], label-side: left, "->")
	edge((0, -1), (0, 0), [$alpha_(g f,h)(theta)$], label-side: left, "->")
	edge((-1, 0), (0, 0), [$alpha_(f,h g)(theta)$], label-side: right, "->")
	edge((-1, -1), (-1, 0), [$f^*alpha_(g,h)(theta)$], label-side: right, "->")
  }))
]

#theorem[
  一个带拉回选择的 $C$ 上的纤维范畴 $p_F:F->C$ 定义了 $C$ 上的一个伪函子
  $ u |-> F(u), quad (f:u->v) |-> (f^*:F(v)->F(u)) $
]

#proof[
  拉回选择给出了每个 $f:u->v$ 的拉回函子 $f^*$. 对恒等态射 $id_u$, 对象 $xi$ 的选定拉回 $(id_u)^*xi->xi$ 与恒等箭头 $xi->xi$ 都是 $xi$ 沿 $id_u$ 的拉回, 因此存在唯一同构
  $ epsilon_u(xi):(id_u)^*xi -> xi $
  关于 $xi$ 自然. 类似地, 对可复合 $u->^f v->^g w$, 对象 $zeta in F(w)$ 的两个对象 $f^*g^*zeta$ 与 $(g f)^*zeta$ 都是 $zeta$ 沿 $g f$ 的拉回, 因而存在唯一同构
  $ alpha_(f,g)(zeta):f^*g^*zeta -> (g f)^*zeta $
  这些唯一同构自动满足单位相容和结合相容: 两条候选复合都是同一个 Cartesian 问题的唯一解. 这就是伪函子公理中图表交换的来源.
]

=== 分裂结构

#definition(title:[分裂结构])[
  纤维范畴上的一个拉回选择 $K$, 若满足:

  1. 包含所有恒等态射.
  2. 对复合封闭.

  则称之为一个*分裂结构* (splitting).
]

配备了分裂结构的纤维范畴称之为*分裂纤维范畴* (split fibred category).

#theorem[
  由一个拉回选择得到的伪函子是严格函子当且仅当这个拉回选择是分裂结构.
]

#proof[
  若拉回选择包含恒等态射并对复合封闭, 那么沿 $id_u$ 的选定拉回就是恒等, 沿 $g f$ 的选定拉回就是先沿 $g$ 再沿 $f$ 的复合, 因而
  $ id^*_u = id_(F(u)), quad f^*g^*=(g f)^* $
  字面成立, 得到严格函子.

  反过来, 若得到的伪函子严格满足这些等式, 则选定的恒等拉回必须就是恒等箭头, 选定的复合拉回必须就是两个选定 Cartesian 箭头的复合. 因此拉回选择包含恒等态射并对复合封闭, 即为分裂结构.
]

#remark[
  分裂结构的作用是把 "典范同构" 升级成 "字面相等". 这在写公式时很舒服, 但在几何中自然出现的拉回通常只给出伪函子. 所以实际工作中更健康的心态是: 不要害怕同构, 只要同构满足相容条件, 它就是正确的数据.
]

== Grothendieck构造

既然纤维范畴加拉回选择能够决定一个伪函子, 反之亦然. 反向构造的过程称为 Grothendieck 构造, 它把每个基底 $u$ 上的范畴 $Phi(u)$, 沿 $f:u->v$ 拉回拼成一个总范畴
$ p:integral_C Phi -> C $

=== 严格函子的Grothendieck构造

我们先来看严格的情况, 这会简单一些, 设有严格反变函子
$ Phi : C^op -> Cat $
意味着:

- 对每个 $u in C$ 有一个范畴 $Phi(u)$.
- 对每个 $f:u->v$ 有拉回函子 $f^*:Phi(v)->Phi(u)$.
- 严格满足 $(id_u)^* = id_(Phi(u))$, $f^*g^*=(g f)^*$.

我们的目标是构造总范畴, 记作 $integral_C Phi$.

我们定义总范畴的对象是一个二元组 $(u,xi)$. 其中
$ u in C, quad xi in Phi(u) $
直观上, $(u,xi)$ 意味着基底 $u$ 上的对象 $xi$. 定义投影
$ p : integral_C Phi -> C, quad (u,xi) |->u $
因此位于 $u$ 上方的对象恰好是 $Phi(u)$ 的对象.

考虑一个态射
$ (u,xi) -> (v,eta) $
它首先应该包含一个基底态射 $f:u->v$, 但 $xi in Phi(u)$ 且 $eta in Phi(v)$, 二者不在同一范畴中, 不能直接写 $xi->eta$, 为了比较它们, 将 $eta$ 沿 $f$ 拉回到 $u$ 得
$ f^* eta in Phi(u) $
现在 $xi$ 和 $f^* eta$ 都属于 $Phi(u)$, 故可给出态射
$ a:xi->f^* eta $
从而定义
$ (u,xi) -->^((f,a)) (v,eta) $
由 $f:u->v$ 和 $a:xi->f^*eta$ 组成, 投影就是
$ p : (f,a) |-> f $
设有两个态射
$ (u,xi)-->^((f,a))(v,eta)-->^((g,b))(w,zeta) $
其中
$ a:xi->f^*eta, quad b:eta->g^*zeta $
为了得到从 $xi$ 到 $(g f)^* zeta$ 的态射, 我们先拉回 $b$ 得
$ f^*b:f^*eta -> f^* g^* zeta $
于是有
$ xi-->^a f^*eta -->^(f^*b) f^*g^*zeta $
因为 $Phi$ 是严格函子, 所以 $f^*g^* zeta = (g f)^* zeta$, 于是我们定义复合为
$ (g,b) compose (f,a) := (g f, f^*b compose a) $
因为严格有 $(id_u)^*xi=xi$, 定义
$ id_((u,xi)) = (id_u,id_xi) $
严格函子的单位律和结合律保证了 $integral_C Phi$ 是一个范畴. 下面我们验证其构成纤维范畴: 取一个基底态射 $f:u->v$ 和 $v$ 上对象 $(v,eta)$. 它沿 $f$ 的拉回显然是 $(u,f^*eta)$. 定义箭头
$ chi_(f,eta) := (f,id_(f^*eta)) : (u,f^*eta) -> (v,eta) $
纤维部分是
$ id_(f^*eta) : f^*eta -> f^*eta $
我们证明其为Cartesian箭头, 设有
$ (w,zeta) -->^((k,b)) (v,eta) $
其中
$ k:w->v, quad b:zeta->k^*eta $
设底层态射 $k$ 过 $f$ 分解:
$ w -->^h u -->^f v, quad k = f h $
要唯一构造
$ (w,zeta) -->^((h,c)) (u,f^*eta) $
使得
$ chi_(f,eta) compose (h,c) = (k,b) $
要定义 $(h,c)$, 需要 $c:zeta->h^*(f^*eta)$, 但因为 $Phi$ 是严格函子, 所以 $h^*(f^*eta) = (f h)^* eta = k^* eta$. 而我们已经有
$ b : zeta -> k^* eta $
于是只能取 $c = b$. 这个选择显然存在且唯一, 因此 $chi_(f,eta)$ 是Cartesian箭头. 于是我们得到了一个纤维范畴
$ p : integral_C Phi -> C $
至于拉回选择, 对每个
$ f:u->v, quad eta in Phi(v) $
统一刚才选择的Cartesian箭头
$ chi_(f,eta) = (f,id_(f^*eta)) : (u,f^*eta) -> (v,eta) $
就得到了一个拉回选择
$ K = { chi_(f,eta) }_(f,eta) $
在严格函子情形, 这个拉回选择是分裂的.

#remark[
  这个构造的核心点是: 总范畴中的箭头不是直接给 $xi->eta$, 而是给
  $ xi -> f^*eta $
  因为 $xi$ 与 $eta$ 住在不同纤维里, 只有把 $eta$ 拉回到 $u$ 上才能比较. 这和几何中的说法完全一致: 要比较 $U$ 上的对象和 $V$ 上的对象, 必须先沿 $U->V$ 把 $V$ 上的对象限制到 $U$.
]

#example[
  若 $Phi=h_x:C^op->Set$ 被视为离散范畴值函子, 则 $integral_C h_x$ 的对象是二元组
  $ (u, f:u->x) $
  态射
  $ (u,f)->(v,g) $
  是一个 $a:u->v$ 使得 $f=g a$. 这正是切片范畴 $C\/x$. 因此可表纤维范畴确实是普通 Yoneda 可表函子的 Grothendieck 构造.
]

=== 伪函子的Grothendieck构造

若
$ Phi : C^op ~> Cat $
是反变的伪函子, 一些细节需要修正. 严格的函子律不再满足, 取而代之的是自然同构
$ alpha_(f,g):f^*g^* =>^~ (g f)^* $
和
$ epsilon_u:id^*_u =>^~ id_(Phi(u)) $
对象和态射不变, 区别在于复合: 仍然取
$ (u,xi)-->^((f,a))(v,eta)-->^((g,b))(w,zeta) $
且
$ a:xi->f^*eta, quad b:eta->g^*zeta $
形成
$ xi-->^a f^*eta -->^(f^*b) f^*g^*zeta $
但现在 $f^*g^* zeta$ 不再严格等于 $(g f)^* zeta$, 而是有自然同构
$ alpha_(f,g)(zeta):f^*g^* zeta -> (g f)^* zeta $
于是我们定义复合为
$ (g,b) compose (f,a) := (g f, alpha_(f,g)(zeta) compose f^*b compose a) $
纤维部分完整形如
$ xi-->^a f^*eta -->^(f^*b) f^*g^*zeta -->^(alpha_(f,g)(zeta)) (g f)^* zeta $
恒等态射类似可以定义成
$ id_((u,xi)) = (id_u,epsilon_u (xi)^(-1)) $
我们建立了从伪函子出发的一系列构造
$ Phi ~> "带拉回选择的纤维范畴" ~> "相伴的伪函子" $
最终得到的伪函子与原伪函子自然同构, 这就是 Grothendieck 构造的核心思想. 这个构造在代数几何中有广泛应用, 它让我们可以合理地说 "纤维范畴理论与伪函子理论是等价的".

#remark[
  伪函子版本中最容易漏掉的是复合里最后的 $alpha_(f,g)$. 如果不插入这个同构, 复合箭头会落在 $f^*g^*zeta$ 中, 而态射定义要求它落在 $(g f)^*zeta$ 中. 伪函子的相干公理正是保证三次复合时, 无论先结合哪两步, 得到的箭头都相同.
]

== 纤维范畴 $QCoh$

我们来定义一个非常重要的纤维范畴 $QCoh\/S -> Sch\/S$. 对每个概形 $U$, 我们定义 $QCoh(U)$ 为 $U$ 上拟凝聚层的范畴. 并且对于给定的态射 $f:U->V$, 有拉回函子
$ f^*:QCoh(V)->QCoh(U) $
然而, 给定两个态射
$ U-->^f V-->^g W $
沿复合的拉回
$ (g f)^*:QCoh(W) -> QCoh(U) $
并不与
$ f^*g^*:QCoh(W) -> QCoh(U) $
字面相等, 而是有自然同构. 事实上, 我们面对的是一个伪函子. 为了证明自然同构, 最简洁的方法是通过前推函子
$ f_*:QCoh(U) -> QCoh(V) $
的严格函子性, 即 $(g f)_* = g_* f_*$, 以及伴随关系. 这意味着对 $U$ 上的拟凝聚层 $cal(M)$ 和 $V$ 上的拟凝聚层 $cal(N)$, 存在典范同构
$ Theta_f (cal(N),cal(M)) : Hom_(cal(O)_V)(cal(N),f_*cal(M)) -->^~ Hom_(cal(O)_U)(f^*cal(N),cal(M)) $
并且关于两个 $cal(M),cal(N)$ 都是自然的, 更明确地说, 有两个函子
$ QCoh(U)^op times QCoh(V) --> Ab $
分别定义为
$ (cal(M),cal(N)) |-> Hom_(cal(O)_V)(cal(N),f_*cal(M)) $
和
$ (cal(M),cal(N)) |-> Hom_(cal(O)_U)(f^*cal(N),cal(M)) $
并且 $Theta_f$ 是这两个函子之间的自然同构.

考虑单位同构, 若 $U$ 是 $S$-概形, 且 $id_U:U->U$ 是恒等态射, 那么推前
$ (id_U)_* : QCoh(U) -> QCoh(U) $
就是恒等函子, 现在若 $cal(M)$ 是 $U$ 上的拟凝聚层, 有典范的伴随同构
$ Theta_(id_U)(cal(M),-) : Hom_(cal(O)_U)(cal(M),(id_U)_*(-)) = Hom_(cal(O)_U)(cal(M),-) -->^~ Hom_(cal(O)_U)((id_U)^*cal(M),-) $
由Yoneda引理, 这对应一个同构
$ epsilon_U(cal(M)) : (id_U)^*cal(M) ->^~ cal(M) $
关于 $cal(M)$ 是自然的, 于是我们得到了函子同构
$ epsilon_U : (id_U)^* =>^~ id_(QCoh(U)) $

考虑复合同构, 考虑两个概形态射
$ U-->^f V-->^g W $
对 $W$ 上的拟凝聚层 $cal(P)$, 有自然同构链
$ Hom_(cal(O)_U)((g f)^*cal(P),-) -->^~ Hom_(cal(O)_U)(cal(P),(g f)_*(-)) $
这里使用的是
$ Theta_(g f)(cal(P),-)^(-1) $
又因为
$ (g f)_* = g_* f_* $
所以有
$
Hom_(cal(O)_W)(cal(P),(g f)_*(-)) = Hom_(cal(O)_W)(cal(P),g_* f_*(-)) -->^~_("伴随") Hom_(cal(O)_V)(g^*cal(P),f_*(-)) -->^~_("伴随") Hom_(cal(O)_U)(f^* g^* cal(P),-)
$
整个复合为
$ Theta_f (g^*cal(P),-) compose Theta_g (cal(P),f_*(-)) compose Theta_(g f)(cal(P),-)^(-1) $ 
所以得到自然同构
$ Hom_(cal(O)_U)((g f)^*cal(P),-) -->^~ Hom_(cal(O)_U)(f^*g^*cal(P),-) $
由Yoneda引理, 这对应一个同构
$ alpha_(f,g)(cal(P)) : f^*g^*cal(P) -->^~ (g f)^*cal(P) $
从而得到函子同构
$ alpha_(f,g) : f^*g^* =>^~ (g f)^* $
两边都是
$ QCoh(W) -> QCoh(U) $
的函子. 这就是伪函子 $QCoh$ 的结合同构. 容易验证这满足伪函子的条件, 与这个伪函子相伴的纤维范畴就是 $QCoh\/S$.

#example[
  在仿射情形这件事非常具体. 设
  $ W=Spec A, quad V=Spec B, quad U=Spec C $
  对应环同态 $A->B->C$. 若 $cal(P)=tilde(M)$ 是 $W$ 上的拟凝聚层, 则
  $ g^*cal(P) tilde.eq tilde(B times.o_A M) $
  再拉回一次得到
  $ f^*g^*cal(P) tilde.eq tilde(C times.o_B (B times.o_A M)) $
  而沿复合拉回得到
  $ (g f)^*cal(P) tilde.eq tilde(C times.o_A M) $
  二者由结合约束
  $ C times.o_B (B times.o_A M) tilde.eq C times.o_A M $
  典范同构. 所以 $QCoh$ 的伪函子性本质上就是张量积结合律的几何版本.
]

== 纤维于群胚的范畴

#definition(title:[纤维于群胚的范畴])[
  一个纤维范畴 $p_F:F->C$, 并且对 $C$ 的每个对象 $u$, 纤维范畴 $F(u)$ 都是一个群胚, 那么称 $F$ 是*纤维于群胚的范畴* (category fibered in groupoids).
]

我们还有另一个等价定义, 陈述如下:

#theorem[
  设 $p_F:F->C$ 是位于 $C$ 上的范畴, 则 $F$ 纤维于群胚当且仅当:

  1. $F$ 的每条箭头都是Cartesian的.
  2. 给定 $eta in F$ 和 $C$ 的任意箭头 $f:u->p_F (eta)$, 存在 $F$ 中的箭头 $phi:xi->eta$ 满足 $p_F (phi)=f$.
]

#proof[
  我们来证明纤维 $F(u)$ 是群胚, 取一条纤维内态射 $phi:xi->eta$, 即 $p_F (phi)=id_u$. 因为 $phi$ 是Cartesian, 对 $id_eta:eta->eta$ 和底层态射 $id_u:u->u$, 存在唯一的态射 $psi:eta->xi$ 使得
  $ p_F (psi) = id_u, quad phi psi = id_eta $
  从而 $phi$ 有右逆. 同理 $psi phi = id_xi$, 于是 $phi$ 是同构.

  反过来, 设 $F$ 是纤维范畴, 并且 $F(u)$ 是群胚, 条件2显然. 只需证明任何态射都Cartesian, 取 $phi:xi->eta$ 投影为 $f:u->v$ 作 $eta$ 沿着 $f$ 的拉回 $phi':xi'->eta$, 因为 $phi'$ 是Cartesian, 存在唯一态射 $a:xi->xi'$ 满足 $phi'a=phi$. 此处 $p_F (a) = id_u$, 因为 $F(u)$ 是群胚, 所以 $a$ 是同构, 于是 $phi$ 也是Cartesian的.
]

#corollary[
  任何从一个纤维范畴到一个纤维于群胚的范畴的保持基底的态射 ($p_G Phi = p_F$) 都是纤维范畴的态射.
]

#remark[
  纤维于群胚的范畴是叠论中最常见的对象, 因为很多几何对象的同构应该被保留, 但非同构态射通常不该放进纤维里. 例如 "向量丛" 形成群胚: 对固定底空间 $U$, 对象是 $U$ 上的向量丛, 态射只取向量丛同构. 若把所有线性映射都放进去, 纤维就不是群胚了, 下降理论的形式也会变复杂.
]

== 纤维于集合的范畴

=== 纤维于集合的范畴

范畴的概念推广了集合的概念, 一个集合也可以以自然的方式视作一个范畴, 即离散范畴:

#definition(title:[离散范畴])[
  设 $C$ 是范畴, 若 $C$ 只有恒等态射, 则称 $C$ 是*离散范畴* (discrete category). 也就是说, 对每个对象 $u in C$, 有
  $ Hom_C (u,u) = {id_u} $
]

一个集合可以典范地视作一个离散范畴, 其对象是集合的元素, 恒等态射是恒等映射. 记作 $"disc"(X)$.

#definition(title:[纤维于集合的范畴])[
  设 $p_F:F->C$ 是纤维范畴, 若对每个对象 $u in C$, 纤维 $F(u)$ 是小离散范畴, 则称 $F$ 是*纤维于集合的范畴* (category fibered in sets).
]

下面也给出纤维于集合范畴的一个有用刻画:

#theorem[
  设 $F$ 是一个位于 $C$ 上的范畴, 那么 $F$ 纤维于集合当且仅当对任意对象 $eta in F$, 以及任意 $C$ 的态射 $f:u->p_F (eta)$, 存在唯一的 $F$ 中的箭头 $phi:xi->eta$ 满足 $p_F (phi)=f$.
]

#proof[
  给定 $eta$ 和 $f:u->p_F (eta)$, 选取一条位于 $f$ 上方的Cartesian态射 $xi->eta$, 如果还有另一条 $f$ 上方的 $xi'->eta$, 那么由Cartesian性, 存在唯一态射 $xi'->xi$ 使得图表
  #align(center, diagram({
	node((-1, 0), [$xi'$])
	node((1, 0), [$xi$])
	node((0, 1), [$eta$])
	edge((-1, 0), (1, 0), "-->")
	edge((1, 0), (0, 1), "->")
	edge((-1, 0), (0, 1), "->")
  }))
  交换, 位于 $id_u$ 上方. 但因为 $F(u)$ 是离散范畴, 所以这个态射是恒等态射, 于是 $xi'=xi$ 并且两条到 $eta$ 的态射相同.

  反之假设上述条件成立, 给出图表
  #align(center, diagram({
	node((0, 0), [$zeta$])
	node((1, 1), [$xi$])
	node((2, 1), [$eta$])
	node((0, 1), [$p_F zeta$])
	node((1, 2), [$p_F xi$])
	node((2, 2), [$p_F eta$])
	edge((0, 0), (0, 1), "|->")
	edge((1, 1), (1, 2), "|->")
	edge((2, 1), (2, 2), "|->")
	edge((0, 1), (1, 2), [$h$], label-side: right, "->")
	edge((1, 2), (2, 2), "->")
	edge((0, 0), (1, 1), [$theta$], label-side: right, "-->")
	edge((1, 1), (2, 1), [$phi$], label-side: right, "->")
	edge((0, 1), (2, 2), "->", bend: 18deg)
	edge((0, 0), (2, 1), [$psi$], label-side: left, "->", bend: 18deg)
  }))
  上述条件保证了存在唯一的在 $h$ 上的态射 $theta:zeta->xi$ 使得图表交换. 于是 $F$ 是纤维于集合的范畴.
]

因此, 对于纤维于集合的范畴, $F$ 中对象沿 $C$ 箭头的拉回严格唯一, 由此可知若 $F->C$ 纤维于集合, 并且 $f:u->v$ 是 $C$ 的态射, 那么拉回映射
$ f^* : F(v) -> F(u) $
是唯一确定的, 并且严格满足复合律
$ f^*g^* = (g f)^* $
此外, 对每个 $u in C$, 都有
$ (id_u)^* : F(u) -> F(u) $
是恒等映射, 意味着我们得到一个函子
$ Phi : C^op -> Set $
将每个对象 $u in C$ 送到集合 $F(u)$, 将每个态射 $f:u->v$ 送到映射 $f^*:F(v)->F(u)$. 这就是纤维于集合的范畴与函子之间的等价关系. 更进一步, 若
$ Psi:F->G $
是纤维于集合的范畴之间的态射, 那么由于其保持基底
$ p_G compose Psi = p_F $
所以对 $C$ 的每个对象 $u$, $Psi$ 都将 $F(u)$ 映射到 $G(u)$, 因此得到一个函数
$ Psi_u:F(u)->G(u) $
容易验证构成自然变换
$ phi_Psi : Phi_F => Phi_G $
在 $C$ 上, 纤维于集合的范畴之间的态射与函子之间的自然变换是一一对应的. 于是我们得到了一个范畴等价
$ "FibSet"(C) tilde.eq Fun(C^op,Set) $

#example[
  可表函子 $h_x$ 对应的纤维于集合的范畴就是切片范畴 $C\/x->C$. 对象是 $u->x$, 它位于 $u$ 上方. 沿 $f:v->u$ 拉回时只是复合
  $ v ->^f u -> x $
  因为纤维是离散的, 不存在额外同构需要记录. 这正是普通预层比纤维于群胚的范畴简单的地方.
]

#remark[
  可以把三种层级粗略记成:
  $ Set "值预层" subset "群胚值预层" subset Cat "值预层" $
  纤维于集合的范畴没有非平凡自同构, 纤维于群胚的范畴允许自同构但不允许非可逆纤维态射, 一般纤维范畴则都允许. 叠主要生活在中间那层.
]

=== 纤维于某个对象之上的范畴

#theorem[
  设 $G->C$ 是一个纤维于集合的范畴, $F$ 是另一个范畴, 并且 $Psi:F->G$ 是一个函子. 那么 $F$ 纤维于 $G$ 上当且仅当其通过复合
  $ p_G compose Psi : F -> C $
  把 $F$ 看作 $C$ 上范畴时, 它纤维于 $C$ 上. 此外:

  1. $F$ 相对 $G$ 纤维于群胚, 当且仅当 $F$ 相对 $C$ 纤维于群胚.
  2. $F$ 相对 $G$ 纤维于集合, 当且仅当 $F$ 相对 $C$ 纤维于集合.
]

#proof[
  可以立即看出, $F$ 的箭头相对 $G$ 是Cartesian的当且仅当相对 $C$ 是Cartesian的. 第一个结论随即成立.

  进一步, 对 $C$ 的任意对象 $u$, $F$ 在 $u$ 上的纤维作为一个范畴是如下各纤维的不交并
  $ union.sq.big_(xi in G(u)) F(xi) $
  这里 $xi$ 取遍 $G(u)$ 的所有对象. 这些都是群胚或集合, 当且仅当他们的不交并也是群胚或集合. 于是第二个结论也成立.
]

这个命题可以这样使用, 设 $s$ 是 $C$ 的一个对象, 并考虑可表函子
$ h_s:C^op->Set $
相对应的纤维于集合的范畴
$ C\/s -> C $
上述定理说明, 一个纤维范畴 $F->C\/s$ 等价于给出:

1. 一个纤维范畴 $F->C$.
2. 一个纤维范畴的态射 $F->C\/s$, 且都位于 $C$ 上.

== 纤维子范畴

#definition(title:[纤维子范畴])[
  设 $F->C$ 是一个纤维范畴, $F$ 的一个子范畴 $G subset F$ 称为一个*纤维子范畴* (fibred subcategory), 如果:

  1. 复合 $G arrow.hook F->C$ 使得 $G$ 本身成为于 $C$ 上的纤维范畴.
  2. $G$ 中的每一条Cartesian态射在 $F$ 中也是Cartesian的.
]

最后这个条件等价于要求包含函子 $G arrow.hook F$ 是一个纤维范畴的态射.

设 $F->C$ 是一个纤维范畴, 而 $G$ 是 $F$ 的一个全子范畴, 并满足若 $eta in G$ 且 $xi->eta$ 是 $F$ 中的一条Cartesian态射, 那么 $xi in G$. 也就是说 $G$ 对拉回封闭. 那么 $G$ 是 $F$ 的一个纤维子范畴. 而且 $G$ 中的Cartesian态射恰好是 $F$ 中终点属于 $G$ 的Cartesian态射. 

例如局部自由层的范畴是
$ QCoh\/S->Sch\/S $
的一个纤维子范畴.

#example[
  固定整数 $r >= 0$, 秩为 $r$ 的局部自由层也构成 $QCoh\/S$ 的纤维子范畴. 这是因为局部自由和秩为 $r$ 都能在底空间上局部检查, 并且被任意拉回保持. 反过来, "全局生成的拟凝聚层" 通常不构成这样的纤维子范畴, 因为全局生成性在任意基变换下未必按朴素方式保持.
]

#remark[
  判定一个全子范畴是否是纤维子范畴时, 最常用的标准就是 "对拉回封闭". 这句话在几何上读作: 你定义的对象类别必须是相对的, 不能依赖某个底空间上的偶然全局性质.
]

== 纤维范畴的等价

=== 保持基底的自然变换

#definition(title:[保持基的自然变换])[
  设 $F,G$ 是两个纤维于 $C$ 上的范畴, 设
  $ Phi,Psi:F->G $
  是两个纤维范畴的态射, 我们称一个自然变换
  $ alpha:Phi => Psi $
  是*保持基底的* (base-preserving), 如果对每个对象 $xi in F$, 分量
  $ alpha_xi:Phi_xi -> Psi_xi $
  属于纤维 $G(u)$, 其中 $u = p_F (xi) = p_G (F xi) = p_G (G xi)$. 也就是说, $p_G (alpha_xi) = id_u$. 因此 $alpha_xi$ 不改变基底, 只是在同一个纤维 $G(u)$ 内给出一个态射.
]

容易验证, 一个保持基底的自然变换的逆变换也是保持基底的.

#remark[
  这里的 "保持基底" 是很强的条件: 分量 $alpha_xi$ 必须落在同一个纤维里, 而不是只允许它在底范畴中投到某个同构. 这样做的好处是, 我们比较的是同一个基底 $u$ 上的对象, 不会把底空间也一起偷偷移动.
]

=== 纤维范畴的等价

#definition(title:[纤维范畴的等价])[
  设 $F,G$ 是两个纤维于 $C$ 上的范畴, 设
  $ Phi:F->G $
  是一个纤维范畴的态射, 我们称 $Phi$ 是一个*纤维范畴的等价* (equivalence of fibred categories), 如果存在一个纤维范畴的态射
  $ Psi:G->F $
  以及两个保持基底的自然同构
  $ alpha:Phi compose Psi tilde.eq id_G, quad beta:Psi compose Phi tilde.eq id_F $
  也就是说, $Phi$ 和 $Psi$ 是纤维范畴之间的等价, 且保持基底.
]

#theorem[
  设 $F,F',G,G'$ 都是纤维于 $C$ 上的范畴, 设
  $ A:F'->F, quad B:G->G' $
  都是纤维范畴的等价, 那么存在范畴等价
  $ Hom_C (F,G) --> Hom_C (F',G') $
  将每个 $Phi:F->G$ 送到复合
  $ B compose Phi compose A : F'->G' $
]

#proof[
  取 $A$ 和 $B$ 的拟逆
  $ A^(-1):F->F', quad B^(-1):G'->G $
  这里的逆都只在纤维范畴等价意义下存在. 上述构造的反向函子把
  $ Psi:F'->G' $
  送到
  $ B^(-1) compose Psi compose A^(-1):F->G $
  两次复合以后, 利用 $A,A^(-1),B,B^(-1)$ 的保持基底自然同构, 就得到与恒等函子自然同构的函子. 因此这是范畴等价.
]

#theorem[
  设 $Phi:F->G$ 是纤维范畴之间的态射, 那么 $Phi$ 是纤维范畴的等价当且仅当对每个对象 $u in C$, 诱导的函子
  $ Phi_u:F(u)->G(u) $
  是范畴等价.
]

#proof[
  若 $Phi$ 有纤维范畴意义下的拟逆, 限制到每个纤维当然给出普通范畴等价.

  反过来, 假设每个 $Phi_u$ 都是范畴等价. 对 $G$ 中对象 $eta$ 位于 $u$ 上方, 选取 $F(u)$ 中对象 $xi$ 以及同构 $Phi_u(xi) tilde.eq eta$. 这些局部选择给出对象层面的拟逆. 对一般态射, 先用 Cartesian 拉回把问题化到同一个纤维内, 再用 $Phi_u$ 的全忠实性唯一提升. 这样得到的拟逆保持 Cartesian 态射, 自然同构也逐纤维给出并保持基底. 细节主要是检查选择与复合相容, 本质上都来自 Cartesian 态射的唯一性.
]

#remark[
  这个判据非常实用: 判断两个纤维范畴是否等价时, 不必直接操纵整个总范畴, 只要逐个基底 $u$ 检查纤维 $F(u)->G(u)$ 是否等价即可. 也就是说, 纤维范畴的等价是 "逐点的".
]

== 2-Yoneda引理

=== 可表纤维范畴

#definition(title:[可表纤维范畴])[
  设 $C$ 是范畴, 固定对象 $x in C$, 与 $x$ 对应的可表函子
  $ h_x = Hom_C (-,x) : C^op->Set $
  的Grothendieck构造是一个纤维于 $C$ 上的范畴
  $ C_(\/x)->C $
  称之为*可表纤维范畴* (representable fibred category).
]

上述构造中, $C_(\/x)$ 是切片范畴, 到基范畴 $C$ 的投影函子是
$ (u->x) |-> u $
纤维
$ C_(\/x) (u) $
的对象是所有箭头 $u->x$, 从而对象集合恰好是
$ h_x (u) = Hom_C (u,x) $
纤维内的态射是恒等态射, 因此 $C_(\/x)$ 是纤维于集合的范畴.

=== 2-Yoneda引理

#theorem(title:[2-Yoneda引理])[
  设 $F->C$ 是纤维范畴, $x in C$, 那么存在自然的范畴等价
  $ Hom_C (C_(\/x),F) tilde.eq F(x) $
  前者是纤维范畴态射对自然变换构成的范畴, 后者是纤维.
]

证明是自然的, 故略. 2-Yoneda可以重新描述可表性, 一个态射
$ Phi : C_(\/x) -> F $
对应一个对象
$ xi in F(x) $
而这个对象定义了一个函子
$ Phi' : C_(\/x) -> F $
与 $Phi$ 同构.

#remark[
  更具体地说, 从 $Phi:C_(\/x)->F$ 出发, 只需要看 $id_x:x->x$ 这个对象的像, 就得到
  $ Phi(id_x) in F(x) $
  反过来, 给定 $xi in F(x)$, 对任意 $u->x$ 把它送到 $xi$ 沿 $u->x$ 的拉回. 这正是普通 Yoneda 引理中 "自然变换由恒等元处的值决定" 的 $2$-范畴版本.
]

#theorem[
  一个 $C$ 上的纤维范畴 $F$ 是可表的, 当且仅当:
  
  1. $F$ 纤维于群胚.
  2. 存在某个对象 $u in C$ 和某个对象
    $ xi in F(u) $
    使得对任意对象 $rho in F$ 都存在唯一的态射
    $ rho -> xi $
    属于 $F$

  直观上, $xi$ 是总范畴 $F$ 的终对象, 而他所在的基底 $u$ 就是表示 $F$ 的对象.
]

#theorem[
  设 $F->C$ 是纤维范畴, 那么一定存在一个典范的分裂的纤维范畴
  $ tilde(F)->C $
  使得有等价 $tilde(F)->^~ F$.
]

== 纤维范畴的等变对象

在一个带有群概形作用的概形上, 定义等变模层往往繁琐且不太直观. 若群概形 $G$ 作用在概形 $X$ 上, 那么 $X$ 上的一个等变层, 应该是 $X$ 上的一个层 $cal(F)$, 再加上 $G$ 对二元组 $(X,cal(F))$ 的一个作用, 并且这个作用与 $G$ 在 $X$ 上的作用相容. 由于 $(X,cal(F))$ 本身就是纤维范畴的一个对象, 所以我们可以用纤维范畴的语言来描述等变层. 这就是纤维范畴的等变对象的概念.

=== $G$-等变对象

#definition(title:[等变对象])[
  设 $G:C^op -> Grp$ 是函子, $p_F:F->C$ 是纤维范畴, $x in C$ 配备了一个 $G$-作用 (@def-group-action), 那么 $F(x)$ 的一个 $G$-*等变* (equivariant) 对象是一个对象 $rho in F(x)$ 伴随了群 $G(u)$ 在集合 $Hom_F (xi,rho)$ 对于任何 $xi in F(u)$ 的作用. 使得下面两个条件成立:

  1. 对任意 $F$ 中的箭头 $phi:xi->eta$ 对应到 $C$ 中的 $f:u->v$, 诱导的映射
    $ phi^*:Hom_F (eta,rho) -->^(- compose phi) Hom_F (xi,rho) $
    相对群同态 $f^*:G(v)->G(u)$ 是等变的, 即
    $ phi^* (g_*a) = (f^*g)_* phi^* (a) $
    对任意 $g in G(v)$ 和 $a:eta->rho$ 成立, 其中 $g_*$ 是 $G(v)$ 在 $Hom_F (eta,rho)$ 上的作用, $(f^*g)_*$ 是 $G(u)$ 在 $Hom_F (xi,rho)$ 上的作用.
  2. 由 $p_F$ 诱导的映射
    $ Hom_F (xi,rho) -> Hom_C (u,x) $
    是 $G(u)$-等变的, 即
    $ p_F (g_*a) = g_* p_F (a) $
    对任意 $g in G(u)$ 和 $a:xi->rho$ 成立, 其中 $g_*$ 是 $G(u)$ 在 $Hom_F (xi,rho)$ 上的作用, 以及在 $Hom_C (u,x)$ 上的作用.

  此外, 一个 $F(x)$ 中的态射 $h:rho->sigma$ 是 $G$-*等变*的, 如果它与群作用相容, 即诱导的映射
  $ Hom_F (xi,rho) -->^(h compose -) Hom_F (xi,sigma) $
  对任何 $u$ 和 $xi in F(u)$ 都是 $G(u)$-等变的, 即
  $ h compose (g_*a) = g_* (h compose a) $
  其中 $g_*$ 是 $G(u)$ 在 $Hom_F (xi,rho)$ 和 $Hom_F (xi,sigma)$ 上的作用.

  $x$ 上的 $G$-等变对象组成一个范畴, 记作 $F^G (x)$, 其态射就是 $G$-等变的态射.
]

第一个条件可以用函子的语言重述: 对于对象 $xi in F$, 给定
$ G compose p_F^op: F^op -->^(p_F^op) C^op -->^G Grp $
在可表函子
$ h_xi = Hom_F (-,xi) : F^op -> Set $
上的作用 (@def-group-action), 也就是说, 对每个对象 $zeta in F$ 有集合论意义下的作用
$ (G compose p_F^op)(zeta) times h_xi (zeta) -> h_xi (zeta) $
并且这些作用组合成自然变换
$ (G compose p_F^op) times h_xi => h_xi $
第二个条件则可以理解为, 这个 $G$ 对 $rho$ 的作用, 与 $G$ 在 $x$ 上的作用相容.

#remark[
  这个定义确实有点绕, 因为它避免提前选择拉回. 若已经选好了拉回, 可以更天真地说: 对每个 $g in G(u)$ 和每个从 $u$ 出发的测试对象, $rho$ 的拉回应该能沿 $g$ 被重新识别, 而且这些识别要和态射自然相容. 下面群对象版本的 $beta$ 正是在把这种识别写成一条具体箭头.
]

=== 当 $G$ 是群对象时

回顾群对象 (@def-group-object) 是与遗忘函子复合后可表的 $C^op->Grp$. 现在假设 $g in C$ 是群对象, 并且作用在对象 $x$ 上. 这个作用相当于态射
$ alpha : g times x -> x $
令
$ rho in F^g (x) $
考虑 $rho$ 沿着第二投影
$ pr_2 : g times x -> x $
的拉回
$ pr_2^* rho in F(g times x) $
它表示一个函子
$ h_(pr^*_2 rho) $
若
$ phi:xi->pr^*_2 rho $
是 $F$ 的态射, 考察交换图表
#align(center, diagram({
	node((0, 0), [$xi$])
	node((2, 1), [$"pr"^*_2 rho$])
	node((2, 2), [$g times x$])
	node((3, 2), [$x$])
	node((3, 1), [$rho$])
	node((0, 1), [$p_F xi$])
	node((1, 2), [$g$])
	edge((2, 1), (3, 1), "->")
	edge((2, 2), (3, 2), [$"pr"_2$], label-side: right, "->")
	edge((0, 0), (0, 1), "|->")
	edge((2, 1), (2, 2), "|->")
	edge((3, 1), (3, 2), "|->")
	edge((0, 1), (2, 2), [$p_F phi$], label-side: center, "->", bend: 18deg)
	edge((0, 0), (2, 1), [$phi$], label-side: center, "->", bend: 18deg)
	edge((0, 0), (3, 1), "->", bend: 36deg)
	edge((0, 1), (3, 2), "->", bend: 36deg)
	edge((2, 2), (1, 2), [$"pr"_1$], label-side: left, "->")
	edge((0, 1), (1, 2), "->")
}))
得到自然变换
$ h_(pr^*_2 rho) => (h_g compose p_F^op) times h_rho $
由于 $p : pr^*_2 rho -> rho$ 是Cartesian的, 每一对 $F$ 中的态射 $xi -> rho$ 和 $C$ 中态射 $p_F xi->g$ 都来自唯一的 $F$ 中的态射 $xi->pr^*_2 rho$. 于是我们得到一个自然同构
$ h_(pr^*_2 rho) tilde.eq (h_g compose p_F^op) times h_rho : F^op -> Set $
由Yoneda引理, $g$ 对 $rho$ 的作用所给出的自然变换
$ (h_g compose p_F^op) times h_rho => h_rho $
对应于一条箭头
$ beta : pr^*_2 rho -> rho $
于是定义中的条件2可以表述为
$ p_F beta = alpha $
也就是说 $beta$ 位于底层作用态射
$ alpha : g times x -> x $
之上, 因此一个 $g$-等变结构可以由一条箭头
$ beta : pr^*_2 rho -> rho $
来描述. 具体地, 我们有:

#theorem[
  设 $rho in F(x)$, 给 $rho$ 一个 $g$-等变结构等价于给出态射 $beta : pr^*_2 rho -> rho$ 满足 $p_F beta = alpha$, 并且满足:

  1. $beta compose eta_rho = id_rho$.
  2. 下图表交换:
  #align(center, diagram({
	node((1, 1), [$"pr"^*_3 rho$])
	node((1, 2), [$"pr"^*_2 rho$])
	node((2, 1), [$"pr"^*_2 rho$])
	node((2, 2), [$rho$])
	edge((2, 1), (2, 2), [$beta$], label-side: left, "->")
	edge((1, 2), (2, 2), [$beta$], label-side: right, "->")
	edge((1, 1), (1, 2), [$tilde(id_g times alpha)$], label-side: right, "->")
	edge((1, 1), (2, 1), [$tilde(m_g times id_x)$], label-side: left, "->")
  }))

  其中:
  - $alpha:g times x->x$ 是 $g$ 在 $x$ 上的作用.
  - $pr_2:g times x->x$, $pr_3:g times g times x->x$ 是投影.
  - $m_g:g times g->g$ 是群对象 $g$ 的乘法.
  - $beta$ 是 $rho$ 沿着 $pr_2$ 的拉回.
  - $e_g:1->g$ 是单位元.
  - $epsilon_x:x = 1 times x -> g times x$ 是单位元的作用.
  - $eta_rho:rho->pr^*_2 rho$ 是沿 $epsilon_x$ 的拉回.
  - $tilde(m_g times id_x)$ 是沿着 $m_g times id_x$ 的拉回, $tilde(id_g times alpha)$ 是沿着 $id_g times alpha$ 的拉回.
]

#theorem[
  若 $rho,rho'$ 都是 $g$-等变的, 分别有
  $ beta:pr^*_2 rho->rho, quad beta':pr^*_2 rho'->rho' $
  表示作用箭头, 则态射 $u:rho->rho'$ 是 $g$-等变的当且仅当下图表交换:
  #align(center, diagram({
    node((1, 1), [$"pr"^*_2 rho$])
    node((1, 2), [$rho$])
    node((2, 1), [$"pr"^*_2 rho'$])
    node((2, 2), [$rho'$])
    edge((1, 1), (1, 2), [$beta$], label-side: right, "->")
    edge((1, 2), (2, 2), [$u$], label-side: right, "->")
    edge((1, 1), (2, 1), [$"pr"^*_2 u$], label-side: left, "->")
    edge((2, 1), (2, 2), [$beta'$], label-side: left, "->")
  }))
]

#example[
  令 $F=QCoh\/S$, 设群概形 $g$ 作用在 $S$-概形 $x$ 上. 那么 $F^g(x)$ 就是通常意义下的 $g$-等变拟凝聚层范畴. 一个对象是 $cal(F) in QCoh(x)$, 外加同构
  $ beta:pr_2^*cal(F) -> alpha^*cal(F) $
  满足单位条件和 cocycle 条件. 也就是说, 群元素把点从 $p$ 移到 $g p$ 时, 层在这两个点附近的拉回也被一致地识别起来.
]

= 下降理论

下降理论要回答的问题是: 什么时候, 一个覆盖上的对象及其数据相容, 来自底空间上的对象.

设 ${p:U->X}$ 是一个覆盖, 例如忠实平坦覆盖, 平展覆盖等. 我们若在 $U$ 上有一个对象 $E_U$, 若他真的是 $X$ 上某个对象 $E$ 的拉回
$ E_U tilde.eq  p^* E $
那么在双重交叠 $U times_X U$ 上, 通过两个投影 $p_1,p_2$ 的两个拉回必然同构
$ p_1^* E_U tilde.eq p_2^* E_U $
并且在三重交叠 $U times_X U times_X U$ 上, 通过三个投影 $p_(12), p_(23), p_(13)$ 的三个拉回也满足余循环条件
$ p_(23)^* phi compose p_(12)^* phi = p_(13)^* phi $
下降理论的核心无非就是两个问题, 即下降数据粘合的有效性, 以及粘合对象的唯一性.

== 下降数据

=== 连续映射与拓扑空间的粘合

我们先来看下降理论的一个原型例子: 令 $cat("Cont") := "Arr"(Top)$ 为连续映射的范畴, 这个范畴可以通过函子
$ p_cat("Cont") : cat("Cont") -> Top, quad (f:X->U) |-> U $
将 $cat("Cont")$ 视作 $Top$ 上的纤维范畴. 纤维 $cat("Cont")(U)$ 是所有映射到 $U$ 的连续映射的范畴, 就是 $Top_(\/U)$.

现在, 假设
$ f:X->U, quad g:Y->U $
是 $cat("Cont")$ 中的两个对象, 我们希望构造一个位于 $U$ 上的连续映射, 也就是 $cat("Cont")(U)$ 的态射
$ phi:X->Y $
假设给定一个 $U$ 的开覆盖 ${U_i}$, 以及位于 $U_i$ 之上的连续映射
$ phi_i : f^(-1)(U_i) --> g^(-1)(U_i) $
进一步假设, 对于任意 $i,j$, 在交集 $U_i inter U_j$ 上, 两个映射 $phi_i$ 和 $phi_j$ 相等, 也就是说
$ phi_i |_(f^(-1)(U_i inter U_j)) = phi_j |_(f^(-1)(U_i inter U_j)) $
那么存在唯一的位于 $U$ 上的连续映射 $phi:X->Y$ 使得它在每个 $f^(-1)(U_i)$ 上的限制就是 $phi_i$. 这就是拓扑空间的粘合引理, 也就是连续映射的下降理论.

现在我们用另一套语言来描述这个问题. 设 $f:V->U$ 是连续映射, $X->U$ 是纤维 $cat("Cont")(U)$ 的一个对象, 那么 $X->U$ 沿 $f$ 的拉回由投影映射
$ V times_U X -> V $
给出. 拉回函子 $f^*:cat("Cont")(U)->cat("Cont")(V)$ 将对象 $X->U$ 送到 $V times_U X -> V$. 并且把 $Top_(\/U)$ 中位于 $U$ 上的连续映射 $phi:X->Y$ 给出的态射, 送到
$ f^*phi = id_V times_(U) phi : V times_U X -> V times_U Y $

现在考虑两个拓扑空间 $X,Y$ 以及连续映射
$ X->S, quad Y->S $
考虑函子
$ underline(Hom)_S (X,Y) : Top_(\/S)^op -> Set $
将每一个位于 $S$ 上的对象 $U->S$ 送到集合
$ Hom_U (U times_S X, U times_S Y) $
也就是所有位于 $U$ 上的连续映射
$ U times_S X -> U times_S Y $
组成的集合. 也就是将 $Hom_S (X,Y)$ 拉回到 $U$ 上. 这个函子在态射上的作用为, 给定一个 $S$ 上的连续映射 $f:V->U$, 将每个连续映射
$ phi : U times_S X -> U times_S Y $
送到拉回
$ f^* phi = id_V times phi : V times_S X = V times_U U times_S X-> V times_U U times_S Y = V times_S Y $
所谓"连续函数可以局部构造并粘合成整体的连续映射", 就是说函子
$ underline(Hom)_S (X,Y) : Top_(\/S)^op -> Set $
关于 $Top$ 的经典拓扑是一个层. 不过事情不止于此, 我们还可以在局部构造拓扑空间并粘合起来, 但空间的粘合会更复杂.

#theorem[
  设给定一个拓扑空间 $U$, 以及一个开覆盖 ${U_i}$, 对于每个三组指标 $i,j,k$, 定义
  $ U_(i j) :=  U_i inter U_j, quad U_(i j k) := U_i inter U_j inter U_k $
  假设对于每个 $i$, 给定一个连续映射
  $ u_i:X_i->U_i $
  并且对于每对指标 $i,j$, 给定一个位于 $U_(i j)$ 上的同胚
  $ phi_(i j):u^(-1)_j U_(i j) -->^~ u^(-1)_i U_(i j) $
  满足余循环条件
  $ phi_(i k) = phi_(i j) compose phi_(j k) : u^(-1)_k U_(i j k) -> u^(-1)_j U_(i j k) -> u^(-1)_i U_(i j k) $
  那么存在一个连续映射 $u:X->U$, 以及同构 $phi_i:u^(-1) U_i ->^~ X_i$ 使得对所有 $i,j$ 有
  $ phi_(i j) = phi_i compose phi_j^(-1) : u^(-1)_j U_(i j) -> u^(-1) U_(i j) -> u^(-1)_i U_(i j) $
]

也就是说, 对象也可以像态射一样, 在覆盖上局部构造并粘合成整体对象. 这就是拓扑空间的下降理论.

=== 下降数据的范畴

设 $C$ 是一个景, 我们已经看到 $C$ 上的一个纤维范畴应该被理解作 $C$ 到范畴范畴 $Cat$ 的函子, 也就是说, 我们可以将其看作一个范畴值的预层, 而直观上说, 所谓叠的概念就是 $C$ 上的一个范畴值层.

设 $F$ 是纤维于 $C$ 上的范畴, 我们固定一个拉回选择, 稍后会说明如何消除这个选择的依赖. 给定一个

#definition(title:[下降数据])[
  
]
