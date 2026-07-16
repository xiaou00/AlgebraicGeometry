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
  3. 对任何极大理想 $frak(m) subset A$, $M times.o_A kappa(frak(m)) = M\/frak(m)M$ 非零.
]

== 非分歧态射


