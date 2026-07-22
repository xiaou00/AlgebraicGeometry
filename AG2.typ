#import "template.typ" : *
#import "@preview/fletcher:0.5.8" : *

#show:conf.with(
  title: "代数几何讲义 II",
  subtitle: "平展上同调",
  author: "xiaou0",
  date: "2026",
)

= 平展态射

在正式入手平展上同调之前, 我们需要解决一个大前置: 什么是平展态射? 我们定义所谓平展态射, 就是 "平坦且非分歧". 所谓平坦的意思是 "没有突然出现的奇异点", 所谓非分歧的意思是 "没有无穷小的切量". 换个角度, 也可以理解为相对维数零的光滑态射. 这类态射在代数几何中有着非常重要的地位, 因为它们保证了许多良好的性质, 比如纤维的行为和上同调的稳定性.

== 平坦模

=== 平坦模的定义

在模范畴 $Mod_A$ 中, 我们可以定义最基本的平坦性:

#definition(title:[平坦模])[
  设 $M$ 是 $A$-模, $M times.o_A -$ 必然右正合. 若其是正合函子, 则称 $M$ 是*平坦模* (flat module).
]

#definition(title:[平坦环同态])[
  若环同态 $A->B$ 使得 $B$ 是平坦 $A$-模, 则称 $A->B$ 是*平坦环同态* (flat ring homomorphism).
]

显然, 我们也可以用等价刻画. 一个模 $M$ 是平坦的当且仅当对单射
$ N' arrow.hook N $
诱导的
$ M times.o_A N' arrow M times.o_A N $
也是单射. 从导出函子的视角也能给出刻画: 一个模 $M$ 是平坦的当且仅当 $Tor_1^A (N,M)=0$. 对任意 $N$ 成立.

#theorem(title:[平坦模的理想判据])[
  $M$ 平坦当且仅当对任意有限生成理想 $I subset A$, 自然映射
  $ I times.o_A M -> M $
  是单射, 映射为 $a times.o m |-> a m$. 其像为 $I M$, 故可写作正合列
  $ 0 --> I times.o_A M --> M --> M\/I M --> 0 $
  等价地, 这个条件还可写作 $Tor^A_1 (A\/I,M)=0$ 对所有有限生成理想 $I subset A$ 成立.
]

#theorem(title:[平坦模的方程判据])[
  $M$ 平坦当且仅当每个有限关系
  $ a_1 m_1 + ... + a_n m_n = 0 $
  都存在有限个 $m'_j in M$ 和 $b_(i j) in A$ 使得
  $ m_i = sum_(j) b_(i j)m'_j $
  并且对每个 $j$ 有
  $ sum_(i) a_i b_(i j) = 0 $
]

#theorem[
  任意投射都是平坦的.
] <thm-projective-flat>

#corollary[
  任何自由模都是平坦的.
] <thm-free-flat>

在模范畴中, 条件的蕴含链为:
$ "自由" ==> "投射" ==> "平坦" $

#theorem[
  设 $S subset A$ 是乘法封闭集, 则 $S^(-1)A$ 是平坦的 $A$-模.
] <thm-localization-flat>

#theorem(title:[Govorov--Lazard定理])[
  平坦模的滤过余极限是平坦模, 反之, 任何平坦模 $M$ 都可看作某个有限秩自由模的滤过余极限
  $ M tilde.eq varinjlim(lambda) F_lambda $
] <thm-govorov-lazard>

#corollary[
  平坦模的任何直和平坦.
] <cor-direct-sum-flat>

#theorem[
  若 $M,N$ 都是平坦 $A$-模, 则 $M times.o_A N$ 也是平坦的. 
] <thm-tensor-flat>

#theorem[
  若有短正合列
  $ 0 --> M' --> M --> M'' --> 0 $
  且 $M',M''$ 都是平坦的, 则 $M$ 也是平坦的.
] <thm-exact-flat>

若 $M$ 是平坦模, 则 $- times.o_A M$ 称之为*平坦基变换* (flat base change), 由定义, 他和商, 核相容.

#theorem(title:[基变换保持平坦性])[
  若 $M$ 是平坦 $A$-模, 对于环同态 $A->B$, $M times.o_A B$ 是平坦 $B$-模. 
] <thm-base-change-flat>

#theorem(title:[平坦性可复合])[
  若 $A$ 是平坦 $B$ 代数, $M$ 是平坦 $A$-模, 则 $M$ 是平坦 $B$-模.
] <thm-comp-flat>

#theorem(title:[平坦是茎局部性质])[
  $M$ 是平坦 $A$-模当且仅当对任意素理想 $frak(p) subset A$, $M_(frak(p))$ 是平坦 $A_(frak(p))$-模.
]

这也说明了平坦性可以在仿射开检查.

== 几何上的平坦

#definition(title:[平坦层])[
  设 $X$ 是概形, $cal(F)$ 是拟凝聚层, 若 $cal(F)_p$ 是平坦 $cal(O)_(X,p)$-模, 则称 $cal(F)$ 在 $p$ 处是*平坦的* (flat), 若对任意点 $p in X$ 都成立, 则称 $cal(F)$ 是平坦的.
]

#definition(title:[平坦概形])[
  若 $cal(O)_X$ 是平坦层, 则称概形 $X$ 是*平坦的* (flat).
]

#definition(title:[平坦态射])[
  设 $f:X->Y$ 是概形态射, 若 $cal(O)_(X,p)$ 是平坦 $cal(O)_(Y,f(p))$-模, 则称 $f$ 在 $p$ 处是*平坦的* (flat), 若对任意点 $p in X$ 都成立, 则称 $f$ 是平坦的.
]

显然 $X$ 平坦当且仅当 $X->Spec ZZ$ 平坦. 这也说明了平坦性是一个相对的概念.

#definition(title:[相对平坦层])[
  设 $f:X->Y$ 是概形态射, $cal(F)$ 是 $X$ 上的拟凝聚层, 若 $cal(F)_p$ 是平坦 $cal(O)_(Y,f(p))$-模, 则称 $cal(F)$ 在 $p$ 处是*相对平坦的* (relatively flat), 若对任意点 $p in X$ 都成立, 则称 $cal(F)$ 是相对平坦的.
]

显然, 这些和我们之前定义的环与模的平坦性相容. 即 $A->B$ 是平坦的当且仅当 $Spec B->Spec A$ 是平坦的. $M$ 是平坦 $A$-模当且仅当 $tilde(M)$ 是相对平坦 $cal(O)_(Spec A)$-层.

#theorem(title:[平坦拉回正合])[
  若 $f:X->Y$ 是平坦态射, 则 $f^*:QCoh_Y -> QCoh_X$ 是正合函子.
] <flat-pullback-exact>

#theorem(title:[平坦保持伴随点])[
  设 $f:X->Y$ 是局部Noether概形的平坦态射, 则 $X$ 的伴随点必然映射到 $Y$ 的伴随点.
]

== 忠实平坦

#definition(title:[忠实平坦模])[
  一个 $A$-模 $M$ 称为*忠实平坦模* (faithfully flat module), 若对于任何 $A$-模的复形
  $ N' --> N --> N'' $
  是正合的当且仅当
  $ M times.o_A N' --> M times.o_A N --> M times.o_A N'' $
  是正合的.
]

#theorem[
  $A->B$ 忠实平坦当且仅当 $A->B$ 平坦且 $Spec B->Spec A$ 是满射.
]

#theorem[
  下列条件等价:
  1. $M$ 是忠实平坦 $A$-模.
  2. 对任何素理想 $frak(p) subset A$, $M times.o_A kappa(frak(p))$ 非零.
  3. 对任何极大理想 $frak(m) subset A$, $M times.o_A kappa(frak(m)) = M\/frak(m)M$ 非re"cmp.utils.feedkeys".run(1)
  Ke
]

== 非分歧态射

#definition(title:[分歧轨迹])[
  设 $f:X->Y$ 是概形之间的态射, 拟凝聚层 $Omega_f$ 的支撑称为 $f$ 的*分歧轨迹* (ramification locus), 其支撑 $"Supp" Omega_f$ 称为 $f$ 的分歧轨迹, 其像称之为*分支轨迹* (branch locus).
]

#definition(title:[分歧态射])[
  设 $f:X->Y$ 是概形之间的态射, 若 $Omega_f=0$, 则称之为*形式非分歧* (formally unramified), 若 $f$ 是局部有限表示的, 则称之为*非分歧* (unramified).
]

#remark[
  有些教材会弱化非分歧的条件为 "局部有限型", 但我们这里坚持使用局部有限表示的定义, 因为它在几何上更自然, 并且和光滑态射的定义相容.
]

#theorem[
  局部闭嵌入是非分歧的.
]

#proof[
  闭嵌入放射局部对应满射
  $ A ->> A\/I $
  从而 $Omega_((A\/I)\/A) = 0$. 开嵌入的局部是同构, 相对微分为零. 故局部闭嵌入是非分歧的.
]

#theorem[
  若 $S$ 是 $A$ 的乘法封闭集, $Spec S^(-1)A->Spec A$ 是非分歧的.
]

#proof[
  因为对任意 $a\/s in S^(-1)A$, 都有
  $ d (a\/s) = s^(-1)d a - a s^(-2)d s = 0 $
  这是因为 $a,s in A$, 从而 $d a = d s = 0$. 于是 $Omega_((S^(-1)A)\/A) = 0$.
]
#theorem[
  若 $ell\/k$ 是有限可分域扩张, 则 $Spec ell->Spec k$ 是非分歧的.
]

#proof[
  由本原元素定理, 存在 $alpha in ell$ 使得 $ell = k(alpha)$. 设 $f(t) in k[t]$ 是其最小多项式, 则 $ell tilde.eq k[t]\/(f)$. 且
  $ Omega_(ell\/k) tilde.eq ell d alpha \/(f'(alpha) d alpha) $
  因为 $f$ 可分, $f'(alpha)!=0$, 从而在 $ell$ 中可逆, 故 $d alpha = 0$, 从而 $Omega_(ell\/k) = 0$. 于是 $Spec ell->Spec k$ 是非分歧的.
]

#theorem(title:[非分歧的纤维判据 I])[
  设 $f:X->Y$ 是局部有限型态射, 则 $f$ 非分歧当且仅当对每个点 $q in Y$, 纤维
  $ f^(-1) (q) = X times_Y Spec kappa(q) $
  在概形意义下是若干个 $Spec K$ 的无交并, 其中 $K\/kappa(q)$ 是有限可分域扩张. 也就是说这个纤维是 $Spec E$, 其中 $E$ 是一个有限 étale $kappa(q)$-代数.
]

#theorem(title:[非分歧的纤维判据 II])[
  设 $f:X->Y$ 是局部有限型态射, 则 $f$ 非分歧当且仅当对每个几何点 $overline(q) in Y$, 纤维
  $ f^(-1)(overline(q))= overline(q) times_Y X $
  是若干个 $overline(q)$ 在概形意义下的无交并.
]

非分歧有一个重要的等价刻画:

#theorem[
  设 $f:X->Y$ 是局部Noether概形之间的局部有限型态射, 则 $f$ 非分歧当且仅当
  $ Delta_f:X-> X times_Y X $
  是开嵌入.
]

#theorem[
  设 $pi:X->Y$ 和 $rho:Y->Z$ 是局部有限型的, 令 $tau=rho compose pi$, 则
  #align(center, diagram({
	node((-1, 0), [$X$])
	node((1, 0), [$Y$])
	node((0, 1), [$Z$])
	edge((-1, 0), (1, 0), [$pi$], label-side: left, "->")
	edge((-1, 0), (0, 1), [$tau$], label-side: right, "->")
	edge((1, 0), (0, 1), [$rho$], label-side: left, "->")
  }))
  1. 若 $tau$ 非分歧, 则 $pi$ 非分歧.
  2. 若 $rho$ 非分歧, $tau$ 相对维数 $n$ 光滑, 则 $pi$ 相对维数 $n$ 光滑.
]

== 光滑态射&平展态射

#definition(title:[光滑态射])[
  若态射 $f:X->Y$ 满足:

  1. $f$ 局部有限表示.
  2. $f$ 相对维数 $n$ 平坦, 即平坦且每个纤维 $X_y$ 具有纯维数 $n$.
  3. $Omega_f$ 是秩 $n$ 向量丛.

  则称 $f$ 是相对维数 $n$ 的*光滑态射* (smooth morphism).
]

我们可以描述平展态射为相对维数零的光滑态射, 也就是:

#definition(title:[平展态射])[
  若态射 $f:X->Y$ 同时是平坦态射和非分歧态射, 则称 $f$ 是*平展态射* (étale morphism).
]

#theorem[
  光滑态射是平坦的.
]

若 $f:X->Y$ 平展, $x|->y$, 并且剩余域相同, 则完备局部环同构
$ hat(cal(O))_(Y,y) tilde.eq hat(cal(O))_(X,x) $
一般情况下, 平展态射在形式邻域上只改变剩余域, 不改变局部奇点结构. 平展态射因此保持很多局部性质, 包括且不限于:

1. 正则性.
2. 既约性.
3. 正规性.
4. Cohen-Macaulay.
5. 局部维数.

这些性质可以通过平展局部验证.

=== 标准平展态射

平展态射在局部上有一个非常具体的方程模型. 设 $A$ 是环, $f(t) in A[t]$ 是首一多项式, 令
$ B_0 = A[t]\/(f(t)) $
因为 $f$ 首一, $B_0$ 作为 $A$-模由
$ 1,t,...,t^(n-1) $
生成且自由. 其中 $n = deg f$. 所以 $A->B_0$ 是有限平坦的. 但其不一定非分歧, 这由导数 $f'(t)$ 控制. 相对微分满足
$ Omega_(B_0\/A) tilde.eq B_0 d t \/ (f'(t) d t) $
因为关系 $f(t)=0$ 微分后给出 $f'(t) d t = 0$. 因此若在某个局部化
$ B = (B_0)_b $
中, $f'(t)$ 可逆, 那么 $d t=0$. 从而 $Omega_(B\/A)=0$. 于是 $A->B$ 非分歧, 从而是平展的. 一个平展态射被称之为*标准平展态射* (standard étale morphism), 是指其局部同构于某个 $A->B$ 的形式, 其中 $B = (A[t]\/(f(t)))_b$, $f$ 是首一多项式, 且 $f'(t)$ 在 $B$ 中可逆. 一个标准事实是, 任何平展态射局部上都同构于某个标准平展态射.

#theorem[
  开嵌入是平展态射.
]

#theorem[
  平展态射的复合和基变换后仍然是平展态射.
]

#theorem[
  若 $phi compose psi$ 和 $phi$ 平展, 则 $psi$ 平展.
]

#theorem[
  若 $f:X->Y$ 是平展态射, 那么:
  1. 对任意 $x in X$, $y=f(x)$, $cal(O)_(X,x)$ 和 $cal(O)_(Y,y)$ 的Krull维数相同.
  2. $f$ 是拟有限的, 即对任意 $y in Y$, $f^(-1)(y)$ 是有限个点的有限集合.
  3. $f$ 在拓扑上是开映射.
  4. 若 $X$ 既约, 则 $Y$ 也既约.
  5. 若 $X$ 正则, 则 $Y$ 也正则.
  6. 若 $X$ 正规, 则 $Y$ 也正规.
]

= 下降理论

设 $Omega\/k$ 是域扩张, 那么一个 $k$-簇 $V$ 自然可以通过基变换诱导出一个 $Omega$-簇 $V_Omega = V times.o_k Omega$. 自然会想: 给出一个 $Omega$-簇 $X$, 还要加上什么信息才能确保存在一个 $k$-簇 $Y$ 使得 $X$ 是 $Y$ 的基变换?

更广泛的下降理论要回答的问题是: 什么时候, 一个覆盖上的对象及其数据相容, 来自底空间上的对象.

设 ${p:U->X}$ 是一个覆盖, 例如忠实平坦覆盖, 平展覆盖等. 我们若在 $U$ 上有一个对象 $E_U$, 若他真的是 $X$ 上某个对象 $E$ 的拉回
$ E_U tilde.eq  p^* E $
那么在双重交叠 $U times_X U$ 上, 通过两个投影 $p_1,p_2$ 的两个拉回必然同构
$ p_1^* E_U tilde.eq p_2^* E_U $
并且在三重交叠 $U times_X U times_X U$ 上, 通过三个投影 $p_(12), p_(23), p_(13)$ 的三个拉回也满足余循环条件
$ p_(23)^* phi compose p_(12)^* phi = p_(13)^* phi $
下降理论的核心无非就是两个问题, 即下降数据粘合的有效性, 以及粘合对象的唯一性.

#let pr = $"pr"$

#remark[
  本章中, 我们使用记号
  $ pr_i:X times ... times X->X $
  表示第 $i$ 个投影. 类似地
  $ pr_(i_1...i_r) : X times ... times X -> X times ... times X $
  表示在第 $i_1,...,i_r$ 个位置上的投影.
]

== 下降数据

#definition(title:[下降数据])[
  设 $S$ 是概形, 设
  $ {f_i:S_i->S}_(i in I) $
  是一族态射, 一个拟凝聚层的*下降数据* (descent datum) 是形容 $(cal(F)_i,phi_(i j))$, 由以下内容组成:

  1. 对每个 $i in I$, $cal(F)_i$ 是 $S_i$ 上的拟凝聚层.
  2. 对每个 $(i,j)in I^2$, 给定一个拟凝聚 $cal(O)_(S_i times_S S_j)$-模同构
  $ phi_(i j) : pr^*_0 cal(F)_i -> pr^*_1 cal(F)_j $
  使得对任意 $(i,j,k)in I^3$, $cal(O)_(S_i times_S S_j times_S S_k)$-模的图表
  #align(center, diagram({
	node((-2, -1), [$pr^*_0 cal(F)_i$])
	node((0, -1), [$pr^*_2 cal(F)_k$])
	node((-1, 0), [$pr^*_1 cal(F)_j$])
	edge((-2, -1), (0, -1), [$pr^*_(02)phi_(i k)$], label-side: left, "->")
	edge((-2, -1), (-1, 0), [$pr^*_(01)phi_(i j)$], label-side: right, "->")
	edge((-1, 0), (0, -1), [$pr^*_(12)phi_(j k)$], label-side: right, "->")
  }))
  交换, 这称之为*余循环条件* (cocycle condition).
] <def-descent-datum>

所谓余循环条件, 可以理解为在三重交上, 从一份数据走到另一份时, 结果不依赖于所选取的路径. 这保证了局部对象之间的识别没有歧义.

#example[
  例如若每个 $cal(F)_i$ 都是秩 $r$ 的自由层
  $ cal(F)_i tilde.eq cal(O)^(plus.o r)_(S_i) $
  在二重交上, 同构 $phi_(i j)$ 可以用可逆矩阵表示
  $ g_(i j) in "GL"_r (cal(O)_(S_i times_S S_j)) $
  那么余循环条件就变为
  $ g_(j k)g_(i j) = g_(i k) $
  这就是经典的 "Čech cocycle" 条件.
]

下降数据之间亦可定义态射

#definition(title:[下降数据的态射])[
  设 $S$ 上的下降数据 $(cal(F)_i,phi_(i j))$ 和 $(cal(G)_i,psi_(i j))$ 已知, 一个*下降数据的态射* (morphism of descent data) 是一族拟凝聚层的态射
  $ alpha_i:cal(F)_i->cal(G)_i $
  使得全体图表
  #align(center, diagram({
	node((-1, 0), [$"pr"^*_0 cal(F)_i$])
	node((0, 0), [$"pr"^*_1 cal(F)_j$])
	node((-1, 1), [$"pr"^*_0 cal(G)_i$])
	node((0, 1), [$"pr"^*_1 cal(G)_j$])
	edge((-1, 0), (-1, 1), [$"pr"^*_0 alpha_i$], label-side: right, "->")
	edge((0, 0), (0, 1), [$"pr"^*_1 alpha_j$], label-side: left, "->")
	edge((-1, 0), (0, 0), [$phi_(i j)$], label-side: left, "->")
	edge((-1, 1), (0, 1), [$psi_(i j)$], label-side: right, "->")
  }))
  交换.
]

对于选定的覆盖 $frak(U)={f_i:S_i->S}_(i in I)$, 我们定义了拟凝聚层的下降数据范畴
$ "Desc"_(QCoh)(frak(U)\/S) $
对象是下降数据, 态射是下降数据的态射.
