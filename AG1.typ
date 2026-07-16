#import "template.typ" : *
#import "@preview/fletcher:0.5.8" : *

#show:conf.with(
  title: "代数几何讲义 I",
  subtitle: "概形理论",
  author: "xiaou0",
  date: "2026",
)

= 预层与层

所谓预层和层, 是一种处理 "局部" 与 "整体" 之间关系的工具. 预层和层的概念在代数几何中有着广泛的应用喵.

== 预层

参考资料:
- #link("https://ncatlab.org/nlab/show/presheaf")

=== 预层的定义

#definition(title:[预层])[
  一个小范畴 $cal(C)$ 上的集合值*预层* (presheaf) 是函子
  $ F : C^"op" -> Set $
  其构成范畴 $PSh(C):="Fun"(C^"op",Set)$. 我们可以用显然的方式将其推广到任何目标范畴 $cal(D)$ 上的预层.
]

在概形的情况下, 我们讨论的 $cal(C)$ 取为拓扑空间 $X$ 上的开集, 对于包含关系构成的偏序, 定义的范畴. 记作 $"Open"(X)$.

=== 预层的基本函子

设 $u:cal(C)->cal(D)$ 是函子, 那么有三个基本函子
$ Lan_(u^"op") tack.l (- compose u^"op") tack.l Ran_(u^"op") $
分别记作
$ u_! tack.l u^* tack.l u_* $
分别称为左前推, 拉回和右前推.

== $star$ 覆盖结构 (coverage) 与景 (site)

参考资料:
- #link("https://ncatlab.org/nlab/show/coverage")
- #link("https://ncatlab.org/nlab/show/site")

=== 覆盖结构

覆盖结构的概念是从 $"Open"(X)$ 中提炼出来的. 抽象地统括了拓扑空间的开集覆盖的概念.

#definition(title:[覆盖结构])[
  设 $cal(C)$ 是一个范畴, $cal(C)$ 上的*覆盖结构* (coverage) 是一个函数 $J : cal(C) -> Set$, 将对象 $U$ 映射为一族形如 ${f_i:U_i -> U}_(i in I)$ 的态射族 (每个态射族称为一个覆盖) 并满足:

  若 ${f_i:U_i->U} in J(U)$ 是覆盖且 $g:V->U$ 是态射, 则存在覆盖 ${h_j:V_j->V} in J(V)$ 使得每个复合 $g h_j$ 过某个 $f_i$ 分解.
  #align(center, diagram({
	node((0, -1), [$V_j$])
	node((1, -1), [$U_i$])
	node((0, 0), [$V$])
	node((1, 0), [$U$])
	edge((1, -1), (1, 0), [$f_i$], label-side: left, "->")
	edge((0, -1), (0, 0), [$h_j$], label-side: right, "->")
	edge((0, 0), (1, 0), [$g$], label-side: right, "->")
	edge((0, -1), (1, -1), [$k$], label-side: left, "->")
  }))
  量词顺序是: $forall f, forall g, exists h, forall j, exists i, exists k$, 上图交换.
]

=== $"Open"(X)$ 的例子

设 $X$ 是拓扑空间. 范畴 $"Open"(X)$ 的对象是 $X$ 的开集, 态射由包含关系给出: 当且仅当 $V subset U$ 时有唯一态射 $V -> U$. 对每个开集 $U subset X$, 定义 $J(U)$ 为所有开覆盖
$ {U_i -> U}_(i in I) $
的集合, 其中每个 $U_i$ 是 $U$ 的开子集, 且 $union_(i in I) U_i = U$. 这里的态射 $U_i -> U$ 就是包含映射.

现在取一个覆盖 ${U_i -> U}_(i in I) in J(U)$, 以及任意态射 $g:V -> U$, 即开集包含 $V subset U$. 令
$ V_i = V ∩ U_i $
则每个 $V_i$ 是 $V$ 的开子集, 且
$ union_(i in I) V_i = V $
显然. 所以 ${V_i -> V}_(i in I)$ 是 $V$ 的开覆盖. 并且每个复合 $V_i -> V -> U$ 都通过 $U_i -> U$ 分解, 因为 $V_i subset U_i$.

因此通常的开覆盖给出了 $"Open"(X)$ 上的覆盖结构. 这个例子是一般 site 概念的基本模型.

=== 景

#definition(title:[景])[
  一个*景* (site) 是一个范畴 $cal(C)$ 上配备覆盖结构 $J$.
]

== 层

参考资料:
- #link("https://ncatlab.org/nlab/show/sheaf")

=== 层的定义

下设site为小范畴 $cal(C)$ 配备覆盖结构 $J$.

#definition(title:[层])[
  设 $(cal(C),J)$ 是一个景, $F in PSh(cal(C))$ 是一个预层. 若对任意覆盖, 一族元素
  $ (s_i)_i, quad s_i in F(U_i) $
  满足对任意 $j,k$ 和对象 $K in cal(C)$ 和态射
  $ U_j <--^f K -->^g U_k $
  且态射满足 $p_j f = p_k g$, 总有 $F(f)(s_j)=F(g)(s_k) in F(K)$. 那么存在唯一的 $s in F(U)$ 使得对所有 $i$, 有 $F(p_i)(s)=s_i$. 满足上述条件的预层称为*层* (sheaf). 记所有 $cal(C)$ 上的层构成的范畴为 $Sh(cal(C),J) subset PSh(cal(C))$.
]

另有人话版本, 参考 #link("https://math.stanford.edu/~vakil/216blog/FOAGjul2724public.pdf") 的定义2.2.6. 说白了层就是要求相容的局部数据可以唯一地拼接成整体数据. 也就是说, 层是满足 "局部到整体" 原则的预层.

=== 层公理

我们通常选取的景, 例如Zariski, étale, fppf, fpqc等都存在纤维积, 我们可以用纤维积来简化层公理的表述. 在拓扑空间的开集范畴中
$ U_i times_U U_j = U_i inter U_j $
层公理可以约定为
$ F(U) -> product_i F(U_i) arrows.rr product_(i,j) F(U_i times_U U_j) $
是等化子. 或者我们也可以简单地验证两个条件:

1. $U$ 上的两个截面若限制在每个 $U_i$ 上相等, 则它们在 $U$ 上相等.
2. 若 $U_i$ 上的截面 $s_i$ 相容, 则唯一确定了 $U$ 上的截面 $s$ 使得 $s|_(U_i)=s_i$.

=== 层化

我们可以 claim that $Sh(cal(C),J) subset PSh(cal(C))$ 是一个反射子范畴, 即存在一个左伴随函子
$ (-)^sharp : PSh(cal(C)) arrows.lr Sh(cal(C),J) : U $
也就是说
$ Hom_(PSh(cal(C)))(F,G) tilde.eq Hom_(Sh(cal(C),J))(F^sharp,G) $
对所有层 $G$ 成立.

参考链接:
- #link("https://ncatlab.org/nlab/show/sheafification")

=== 逆像层

#definition(title:[逆像层])[
  设 $f:X->Y$ 是拓扑空间的连续映射, $u:"Open"(Y)->"Open"(X)$, 则
  $ f^(-1)cal(F) := (Lan_(u^"op")(cal(F)))^sharp $
  称之为 $cal(F)$ 沿 $f$ 的*逆像层* (inverse image sheaf).
]

显然有伴随对

$ f^(-1):Sh(Y) arrows.lr Sh(X):f_* $

== 茎

=== 茎的定义

#definition(title:[茎])[
  设 $F$ 是拓扑空间 $X$ 上的预层, $x in X$ 是一个点. 则
  $ F_x := varinjlim(U in.rev x)F(U) $
  称之为 $F$ 在点 $x$ 处的*茎* (stalk), 其中极限是取在所有包含 $x$ 的开集 $U$ 上, 且态射由限制映射给出.
]

这是一个 "局部" 的概念, 反映了预层在点 $x$ 附近的行为. 茎的概念在代数几何中有着重要的应用, 例如在定义纤维和研究局部性质时. 茎的元素称为*芽* (germ), 也就是在点 $x$ 附近的局部截面. 可以表示为一个等价类 $(U,s)$, 其中 $U$ 是包含 $x$ 的开集, $s in F(U)$ 是一个截面. 两个对 $(U,s)$ 和 $(V,t)$ 等价当且仅当存在包含 $x$ 的开集 $W subset U inter V$ 使得 $s|_W = t|_W$.

= 赋环空间

== 赋环空间

=== 赋环空间的定义

#definition(title:[赋环空间])[
  一个*赋环空间* (ringed space) 是一对 $(X,cal(O)_X)$, 其中 $X$ 是拓扑空间, $cal(O)_X$ 是 $X$ 上的交换环层. 称 $cal(O)_X$ 为 $X$ 的*结构层* (structure sheaf).
]

说白了, 赋环空间就是一个拓扑空间, 但我们不只记住点和开集, 还给每个开集 $U subset X$ 配上一环 "函数"
$ cal(O)_X (U) $
并要求这些函数可以限制到更小的开集, 且满足层的拼接条件. 所以拓扑空间负责描述局部范围, 结构层负责描述在这些局部范围上的代数对象.

在代数几何里, $cal(O)_X (U)$ 通常应当被理解为 $U$ 上的正则函数 (也就是没有极点的函数). 在微分几何里, 它可以是 $U$ 上的光滑函数. 这就是 "空间 = 拓扑 + 函数" 的基本思想.

=== 赋环空间的态射

#definition(title:[赋环空间的态射])[
  设 $(X,cal(O)_X)$ 和 $(Y,cal(O)_Y)$ 是赋环空间. 一个赋环空间的态射
  $ (f,f^sharp):(X,cal(O)_X)->(Y,cal(O)_Y) $
  由一个连续映射 $f:X->Y$ 和一个环层态射
  $ f^sharp:cal(O)_Y -> f_* cal(O)_X $
  构成. 由伴随性, 等价地, 也可以给出一个环层态射
  $ f^flat:f^(-1)cal(O)_Y -> cal(O)_X $
]

这里 $f^sharp$ 的方向要注意: 它不是把 $X$ 上的函数推到 $Y$ 上, 而是把 $Y$ 上的函数拉回到 $X$ 上. 对每个开集 $V subset Y$, 有环同态
$ f^sharp_V:cal(O)_Y (V) -> cal(O)_X (f^(-1)(V)) $
可以理解为把 $V$ 上的函数 $g$ 变成 $g compose f$. 态射的方向和函数拉回的方向相反, 这是几何中常见的反变现象. 空间的映射 $X->Y$ 给出函数环的映射 $"Func"(Y)->"Func"(X)$.

== 局部赋环空间

=== 局部赋环空间的定义

#definition(title:[局部赋环空间])[
  一个*局部赋环空间* (locally ringed space) 是赋环空间 $(X,cal(O)_X)$, 使得对任意点 $x in X$, 茎 $cal(O)_(X,x)$ 都是局部环.
]

也就是说, 在每个点 $x$ 附近的函数芽构成一个局部环. 它有唯一的极大理想, 通常记作
$ frak(m)_x subset cal(O)_(X,x) $
几何意义是: $cal(O)_(X,x)$ 记录了点 $x$ 附近的函数, 而 $frak(m)_x$ 记录了在点 $x$ 处取值为 $0$ 的函数芽. 因此剩下的商
$ kappa(x) := cal(O)_(X,x) \/ frak(m)_x $
可以看成点 $x$ 的*剩余域* (residue field), 也就是在该点取值的地方. 对于流形, $cal(O)_(X,x)$ 是在 $x$ 处光滑函数芽的环, 极大理想就是所有在 $x$ 处值为 $0$ 的函数芽. 一个函数芽可逆当且仅当它在 $x$ 处的值非零. 这正是局部环条件的几何来源.

=== 局部赋环空间的态射

#definition(title:[局部赋环空间的态射])[
  设 $(X,cal(O)_X)$ 和 $(Y,cal(O)_Y)$ 是局部赋环空间. 一个局部赋环空间的态射是赋环空间态射
  $ (f,f^sharp):(X,cal(O)_X)->(Y,cal(O)_Y) $
  使得对每个 $x in X$, 诱导的茎同态
  $ f^sharp_x:cal(O)_(Y,f(x)) -> cal(O)_(X,x) $
  是局部环同态, 即
  $ f^sharp_x (frak(m)_(f(x))) subset frak(m)_x $
]

局部环同态这个条件不是装饰, 它保证 "在点上取值" 的操作与态射相容. 换句话说, $Y$ 上在 $f(x)$ 处消失的函数, 拉回到 $X$ 后应当在 $x$ 处消失; 反过来, 若一个 $Y$ 上的函数在 $f(x)$ 处不消失, 那么它拉回后在 $x$ 处也不消失, 因而仍然是局部可逆的.

这就是为什么概形的态射定义在局部赋环空间范畴中, 而不只是在赋环空间范畴中. 单纯的环层态射可能不尊重点的局部代数结构.

== 模层

=== 模层的定义

想要理解模层, 只需将赋环空间的结构层 $cal(O)_X$ 看作一个环, 然后考虑在这个环上定义的模.

#definition(title:[模层])[
  设 $(X,cal(O)_X)$ 是赋环空间. 一个 $cal(O)_X$-*模层* (module sheaf) 是一个Abel群层 $cal(F)$, 并且对于每个 $U$, $cal(F)(U)$ 是 $cal(O)_X (U)$-模, 且对于包含 $U subset V$ 有显然的交换图表
  #align(center, diagram({
	node((0, -1), [$cal(O)_X (V) times cal(F) (V)$])
	node((0, 0), [$cal(O)_X (U) times cal(F) (U)$])
	node((1, -1), [$cal(F) (V)$])
	node((1, 0), [$cal(F) (U)$])
	edge((0, -1), (1, -1), "->")
	edge((0, 0), (1, 0), "->")
	edge((1, -1), (1, 0), "->")
	edge((0, -1), (0, 0), "->")
  }))
  其中横向的箭头是模作用, 纵向的箭头是限制.
]

模层的态射定义也很显然, 即一个模层态射是一个Abel群层态射, 并且自然有图表交换
#align(center, diagram({
	node((0, -1), [$cal(O)_X (V) times cal(F) (V)$])
	node((0, 1), [$cal(O)_X (U) times cal(F) (U)$])
	node((2, -1), [$cal(F) (V)$])
	node((2, 1), [$cal(F) (U)$])
	node((1, 0), [$cal(O)_X (V) times cal(G) (V)$])
	node((1, 2), [$cal(O)_X (U) times cal(G) (U)$])
	node((3, 0), [$cal(G) (V)$])
	node((3, 2), [$cal(G) (U)$])
	edge((0, -1), (2, -1), "->")
	edge((0, 1), (2, 1), "->")
	edge((2, -1), (2, 1), "->")
	edge((0, -1), (0, 1), "->")
	edge((1, 0), (3, 0), "->")
	edge((1, 2), (3, 2), "->")
	edge((3, 0), (3, 2), "->")
	edge((1, 0), (1, 2), "->")
	edge((0, -1), (1, 0), [$id times phi(V)$], label-side: left, "->")
	edge((0, 1), (1, 2), [$id times phi(U)$], label-side: left, "->")
	edge((2, -1), (3, 0), [$phi(V)$], label-side: left, "->")
	edge((2, 1), (3, 2), [$phi(U)$], label-side: left, "->")
}))

这个定义本质就是 "$cal(O)_X$-线性性", 也就是 $phi(a dot s) = a dot phi(s)$. 

=== 模层的前推和拉回

#definition(title:[模层的前推])[
  设 $f:(X,cal(O)_X)->(Y,cal(O)_Y)$ 是赋环空间态射, $cal(F)$ 是 $cal(O)_X$-模层. 则 $f_*cal(F)$ 自然是 $cal(O)_Y$-模层. 对开集 $V subset Y$,
  $ (f_*cal(F))(V)=cal(F)(f^(-1)(V)) $
  其中 $cal(O)_Y(V)$ 通过
  $ f^sharp_V:cal(O)_Y(V)->cal(O)_X(f^(-1)(V)) $
  作用在右边.
]

所以前推只是把 $X$ 上的截面放到 $Y$ 的开集上看. 模结构来自函数的拉回: $Y$ 上的函数先拉回成 $X$ 上的函数, 然后再作用在 $X$ 上的模截面上.

#definition(title:[模层的拉回])[
  设 $cal(G)$ 是 $cal(O)_Y$-模层. 定义
  $ f^*cal(G):=f^(-1)cal(G) times.o_(f^(-1)cal(O)_Y) cal(O)_X $
  其中 $cal(O)_X$ 通过
  $ f^flat:f^(-1)cal(O)_Y -> cal(O)_X $
  看成 $f^(-1)cal(O)_Y$-代数.
]

这里不能只取逆像层 $f^(-1)cal(G)$, 因为它只是 $f^(-1)cal(O)_Y$-模. 为了得到 $X$ 上的模层, 还要把标量扩张到 $cal(O)_X$. 仿射地说, 若 $X="Spec" B$, $Y="Spec" A$, 且 $A->B$ 是对应的环同态, 那么
$ tilde(M) |-> tilde(M times.o_A B) $
所以拉回就是张量积换底的层版本.

前推和拉回满足伴随性
$ Hom_(cal(O)_X)(f^*cal(G),cal(F)) tilde.eq Hom_(cal(O)_Y)(cal(G),f_*cal(F)) $
这也是它们定义成这样的主要原因.

== 流形

流形是理解赋环空间的一个很好的 sanity check. 设 $M$ 是光滑流形, 令
$ cal(O)_M(U)=C^oo(U,RR) $
即 $U$ 上的光滑函数. 光滑函数可以限制, 也可以由局部光滑函数粘贴, 所以 $cal(O)_M$ 是环层. 因此
$ (M,cal(O)_M) $
是赋环空间.

对每个点 $p in M$, 茎 $cal(O)_(M,p)$ 是 $p$ 附近的光滑函数芽. 它的唯一极大理想是
$ frak(m)_p={f in cal(O)_(M,p): f(p)=0} $
因为函数芽可逆当且仅当它在 $p$ 处的值非零. 因此
$ (M,cal(O)_M) $
是局部赋环空间.

若 $f:M->N$ 是光滑映射, 则对 $V subset N$ 和 $g in C^oo(V,RR)$ 定义
$ f^sharp_V(g)=g compose f $
这给出局部赋环空间态射
$ (M,cal(O)_M)->(N,cal(O)_N) $
概形的想法和这里完全平行: 拓扑空间负责给出局部范围, 结构层负责记录这些局部范围上的函数.

= 仿射概形

== 素谱

#definition(title:[素谱])[
  设 $A$ 是交换环. 定义
  $ "Spec" A := {frak(p) subset A : frak(p) " is prime"} $
  对理想 $I subset A$, 定义
  $ V(I):={frak(p) in "Spec" A : I subset frak(p)} $
  并规定这些 $V(I)$ 为闭集. 这给出 $"Spec" A$ 上的Zariski拓扑.
]

这个定义把环论中的理想翻译成几何中的闭集. 当 $A=k[x_1,...,x_n]$ 时, $V(I)$ 可以理解为方程组 $I$ 的零点集, 只是 $"Spec" A$ 还保留了所有素理想对应的点.

主开集定义为
$ D(f):="Spec" A \\ V(f)={frak(p): f in.not frak(p)} $
这些 $D(f)$ 构成 $"Spec" A$ 的拓扑基. 直观上, $D(f)$ 是 $f$ 不消失的地方, 因此在 $D(f)$ 上 $f$ 应该变成可逆元.

== 结构层

在主开集上定义
$ cal(O)_("Spec" A)(D(f))=A_f $
并用局部化的自然映射作为限制映射. 这样可以粘成 $"Spec" A$ 上的环层 $cal(O)_("Spec" A)$. 关键性质是
$ Gamma("Spec" A,cal(O)_("Spec" A)) tilde.eq A $
以及
$ cal(O)_("Spec" A,frak(p)) tilde.eq A_(frak(p)) $
后者是局部环, 极大理想为 $frak(p)A_(frak(p))$. 因此 $"Spec" A$ 带结构层后是局部赋环空间.

#definition(title:[仿射概形])[
  一个#strong[仿射概形] (affine scheme) 是与某个
  $ ("Spec" A,cal(O)_("Spec" A)) $
  同构的局部赋环空间.
]

环同态 $A->B$ 给出概形态射
$ "Spec" B -> "Spec" A $
点 $frak(q)$ 被送到其逆像 $frak(q) inter A$. 反过来, 仿射概形之间的态射都来自这样的环同态. 因此有反变等价
$ ("CRing")^"op" tilde.eq "AffSch" $

= 概形

== 概形的定义

#definition(title:[概形])[
  一个#strong[概形] (scheme) 是局部赋环空间 $(X,cal(O)_X)$, 使得 $X$ 可以被开集 $U_i$ 覆盖, 且每个 $(U_i,cal(O)_X|_(U_i))$ 都是仿射概形.
]

也就是说, 概形就是局部看起来像 $"Spec" A$ 的空间. 这和流形局部看起来像 $RR^n$ 很像, 只是概形的局部模型不是欧氏空间, 而是交换环的素谱.

若 $X$ 是概形, 一个开集 $U subset X$ 若本身是仿射概形, 就称为仿射开集. 概形上的很多问题都可以先限制到仿射开覆盖上, 变成环论问题, 再检查这些局部结果能否粘起来.

基本例子包括:

1. 每个 $"Spec" A$ 都是概形.
2. 射影空间 $PP^n_A$ 由标准仿射开集 $D_+(x_i)$ 覆盖.
3. 概形的开子空间仍然是概形.

= 概形的态射

#definition(title:[概形态射])[
  概形之间的态射就是它们作为局部赋环空间的态射. 也就是说, 态射
  $ f:X->Y $
  包含连续映射 $f$ 和结构层态射
  $ f^sharp:cal(O)_Y -> f_*cal(O)_X $
  并且在茎上诱导局部环同态.
]

在仿射情形中, 这正好退化为环同态的反方向:
$ Hom_("Sch")("Spec" B,"Spec" A) tilde.eq Hom_("CRing")(A,B) $
给定 $phi:A->B$, 底层点的映射为
$ frak(q) |-> phi^(-1)(frak(q)) $
结构层上的映射由局部化诱导. 这就是几何态射与函数拉回方向相反的基本现象.

若 $S$ 是固定概形, 一个 $S$-概形就是带结构态射 $X->S$ 的概形. 当 $S="Spec" k$ 时, 我们也说 $X$ 是 $k$-概形.

= 拟凝聚层

== 拟凝聚层的定义

若 $X="Spec" A$ 且 $M$ 是 $A$-模, 可以定义模层 $tilde(M)$ by
$ tilde(M)(D(f))=M_f $
这给出从普通模到模层的构造.

#definition(title:[拟凝聚层])[
  设 $X$ 是概形, $cal(F)$ 是 $cal(O)_X$-模层. 若存在仿射开覆盖 $X=union_i U_i$, $U_i="Spec" A_i$, 使得
  $ cal(F)|_(U_i) tilde.eq tilde(M_i) $
  对某个 $A_i$-模 $M_i$ 成立, 则称 $cal(F)$ 是#strong[拟凝聚层] (quasi-coherent sheaf).
]

说白了, qcoh 就是局部由模给出的模层. 在仿射概形上有范畴等价
$ "Mod"_A tilde.eq "QCoh"("Spec" A), quad M |-> tilde(M) $
其逆由全局截面给出. 所以在仿射概形上, qcoh 层没有比普通模多出额外信息.

若局部对应的模可以取为有限生成模, 在局部Noether情形下就得到凝聚层 (coherent sheaf). 之后讨论上同调时, qcoh/coh 是主要对象, 因为它们在仿射开集上能直接转化为模的计算.

= 向量丛 & 线丛

== 局部自由层

#definition(title:[局部自由层])[
  设 $X$ 是概形. $cal(O)_X$-模层 $cal(E)$ 称为#strong[局部自由的] (locally free), 若存在开覆盖 $X=union_i U_i$ 使得
  $ cal(E)|_(U_i) tilde.eq cal(O)_(U_i)^(plus.o r_i) $
  若所有 $r_i$ 都等于同一个 $r$, 则称 $cal(E)$ 是秩 $r$ 的局部自由层.
]

局部自由层就是概形上的向量丛. 它局部有一组基, 但这些局部基在交集上的过渡函数可能不平凡. 秩 $1$ 的局部自由层称为线丛, 也称为可逆层.

线丛可逆的意思是: 若 $cal(L)$ 是线丛, 则
$ cal(L)^*:=cal(Hom)_(cal(O)_X)(cal(L),cal(O)_X) $
满足
$ cal(L) times.o cal(L)^* tilde.eq cal(O)_X $
因此线丛在张量积下构成群, 称为Picard群
$ "Pic"(X) $

最重要的例子是射影空间上的Serre扭层
$ cal(O)_(PP^n_A)(m) $
对射影概形 $X arrow.r.hook PP^n_A$, 定义
$ cal(O)_X(1)=cal(O)_(PP^n_A)(1)|_X $
并记
$ cal(F)(m)=cal(F) times.o cal(O)_X(m) $

= 上同调


我们需要Cohomology的动机之一是非常自然的, 因为在 $"QCoh"(X)$ 上的全局截面函子
$ Gamma(X,-) $
是一个左正合的函子, 若
$ 0 -> cal(F) -> cal(G) -> cal(H) -> 0 $
是概形上qcoh的短正合列, 则
$ 0 -> Gamma(X,cal(F)) -> Gamma(X,cal(G)) -> Gamma(X,cal(H)) $
也是正合的, 但是注意这个序列通常不能再往后延伸了, 例如设
$ X = PP^1 $
考虑正合列
$ 0 -> cal(O)(-1) ->^alpha cal(O)(-1)^(plus.o 2) ->^beta cal(O) -> 0 $
其中 $beta:(a,b)|-> x_0 a+x_1 b$, $alpha:c|->(-x_1 c, x_0 c)$. 复合为零, 易证其正合, 但作用 $Gamma(X,-)$ 后, 
$ 0 -> Gamma(X,cal(O)(-1)) ->^alpha Gamma(X,cal(O)(-1)^(plus.o 2)) ->^beta Gamma(X,cal(O)) $
封顶了, 原本的层态射 $cal(O)(-1)^(plus.o 2) -> cal(O)$ 是满射, 即 $cal(O)$ 的局部截面可以提升到 $cal(O)(-1)^(plus.o 2)$, 但全局截面上, $cal(O)(-1)$ 根本没有非零全局截面! 常数函数
$ 1 in Gamma (PP^1, cal(O)) = k $
虽然局部可以写作 $1 = x_0 a+x_1 b$ 的形式, 但无法粘贴到全局. #strong[上同调刻画的就是局部数据是否能粘贴成全局数据, 以及粘贴失败的方式].

== 上同调期望的性质

在我们具体给出上同调的定义 (Čech/导出函子) 之前, 我们先来看一下我们期望上同调满足哪些性质.

假设 $X$ 是一个 sep & qc 的 $A$-概形, 对每个qcoh $cal(F)$ on $X$, 我们会定义 $A$-模 $H^i (X,cal(F))$. 特别地, 若 $A=k$ 是一个域, 则 $H^i (X,cal(F))$ 是 $k$-线性空间, 此时定义
$ h^i (X,cal(F)) = dim_k H^i (X, cal(F)) $
此外, 我们期望:

1. 每个 $H^i (X,-)$ 都是协变函子 $"QCoh"_X -> "Mod"_A$.
2. 函子 $H^0 (X,-)$ 与全局截面函子 $Gamma(X,-)$ 相同.
3. 若 $0 -> cal(F) -> cal(G) -> cal(H) -> 0$ 是 $"QCoh"_X$ 上的短正合列, 则存在长正合列
$ 
  0 --> H^0 (X,cal(F)) --> H^0 (X,cal(G)) --> H^0 (X,cal(H)) \
    -->^delta H^1 (X,cal(F)) --> H^1 (X,cal(G)) --> H^1 (X,cal(H)) \
    -->^delta ...
$
4. 若 $pi:X -> Y$ 是sep & qc $A$-概形态射, $cal(F)$ 是 $X$ 上的qcoh, 则有自然态射 $H^i (Y,pi_*cal(F)) -> H^i (X,cal(F))$, extending $Gamma (Y,pi_*cal(F)) -> Gamma(X,cal(F))$. 也就是说 $H^i$ 在某些意义上是关于概形的反变函子.
5. 若 $pi:X -> Y$ 额外是affine的, 则 $H^i (Y,pi_*cal(F)) ->^tilde H^i (X,cal(F))$ 是同构.
6. 若 $X$ 能被 $n$ 片仿射开集覆盖, 则 $H^i (X,cal(F)) = 0$ 对所有 $i >= n$ 和 $cal(F)$ 都成立. 特别地, 仿射概形的高阶上同调全为零.
7. 函子可以和层的滤过余极限 (包括直和) 交换, 即 $H^i (X,"colim" cal(F)_j) = "colim" H^i (X,cal(F)_j)$.

== 内射对象和解消

=== 内射对象

#definition(title:[内射对象])[
  在一个Abel范畴 $cal(A)$ 中, 一个对象 $I$ 被称为#strong[内射的] (injective), 若对于任意单射 $A arrow.r.hook B$ 和态射 $A -> I$, 都存在态射 $B -> I$ 使得下图交换
  $
  #diagram(
    node((0,0),$A$),
    node((0,1),$B$),
    node((1,0),$I$), 
    edge((0,0),(0,1),"hook->"), 
    edge((0,0),(1,0),"->"),
    edge((0,1),(1,0),"->",label:$exists$,label-side:right),
  )
  $
  也就是说任何从子对象到 $I$ 的态势都可以延拓到整个对象.
]

#theorem[
  $I$ 内射当且仅当 $"Hom"(-,I)$ 正合.
]

#proof[
  我们知道 $"Hom"(-,I)$ 左正合, 对于任给短正合列
  $ 0 --> A -->^u B -->^v C --> 0 $
  作用反变函子 $"Hom"(-,I)$ 后得到
  $ 0 --> "Hom"(C,I) -->^(v^*) "Hom"(B,I) -->^(u^*) "Hom"(A,I) $
  Where
  $ v^* (f) = f compose v, quad u^* (g) = g compose u $
  唯一不足只有最后的满射性
  $ "Hom"(B,I) --> "Hom"(A,I) $
  而 $I$ 内射正是保证了对于任意 $g:A->I$, 都存在 $f:B->I$ 使得 $g = f compose u$, 即 $u^* (f) = g$.
]

=== 内射解消

#definition(title:[内射解消])[
  设 $cal(A)$ 是一个Abel范畴, $"Ch"(cal(A))$ 中对象 $X^bullet$ 的#strong[内射解消] (injective resolution) 是一个从复形 $I^bullet$ 到 $X^bullet$ 的拟同构, 使得 $I^bullet$ 的每个分量 $I^n$ 都是内射对象.
]

对于复形
$ dots.c --> 0 --> X --> 0 --> dots.c $
其内射解消形如
$
#diagram(
  node((0,0),$dots.c$),
  node((1,0),$0$),
  node((2,0),$X$),
  node((3,0),$0$),
  node((4,0),$dots.c$),
  edge((0,0),(1,0),"->"),
  edge((1,0),(2,0),"->"),
  edge((2,0),(3,0),"->"),
  edge((3,0),(4,0),"->"),
  node((0,1),$dots.c$),
  node((1,1),$I^(-1)$),
  node((2,1),$I^0$),
  node((3,1),$I^1$),
  node((4,1),$dots.c$),
  edge((0,1),(1,1),"->"),
  edge((1,1),(2,1),"->"),
  edge((2,1),(3,1),"->"),
  edge((3,1),(4,1),"->"),
  edge((1,0),(1,1),"->"),
  edge((2,0),(2,1),"->"),
  edge((3,0),(3,1),"->"),
)
$
本质上有用信息就是从 $X$ 出发的一串内射对象
$ X --> I^0 --> I^1 --> dots.c $
并且是正合的 (零调).

#theorem[
  若 $X$ 是单个对象 $dots.c -> 0 -> X -> 0 -> dots.c$, 内射解消在同伦意义下唯一, 即在 $"K"(cal(A))$ 中是同构的, 从而在导出范畴 $"D"(cal(A))$ 中也是同构的.
]

#proof[
   略.
]

== (右)导出函子

#definition(title:[右导出函子])[
  设 $F:cal(A)->cal(B)$ 是Abel范畴之间的左正合函子, 并且 $cal(A)$ 有足够内射对象, 对任何对象 $A in cal(A)$, 取内射解消
  $ 0 -> A -> I^0 -> I^1 -> dots.c $
  则定义 $F$ 的第 $i$ 个#strong[右导出函子] (right derieved functor) $R^i F:cal(A)->cal(B)$ 如下
  $ R^i F(A) := H^i (F(I^bullet)) $
  也就是
  $ R^i F(A) = (ker (F(I^i) --> F(I^(i+1))))/(im (F(I^(i-1)) --> F(I^i))) $  
]

导出函子的唯一性显然是确定的, 不依赖于内射解消的选择.

== Grothendieck谱序列

#definition(title:[Grothendieck谱序列])[
  设 $F:cal(A) -> cal(B)$ 和 $G:cal(B) -> cal(C)$ 是左正合的加性协变函子, $cal(A)$ 和 $cal(B)$ 有充分内射对象, 设 $F$ 将 $cal(A)$ 的内射对象打到 $cal(B)$ 的 $G$-acyclic 对象, 则对任意 $X in cal(A)$ 都有谱序列, 满足 $E^(p,q)_2=R^q G(R^p F(X))$ 收敛到 $R^bullet (G compose F) (X)$. 称之为#strong[Grothendieck复合函子谱序列] (Grothendieck spectral sequence).
]

== Leray谱序列

#definition(title:[Leray谱序列])[
  设 $pi:X->Y$ 是赋环空间态射, 对任何 $cal(O)_X$-模层 $cal(F)$, 存在一个谱序列, 其 $E_2$ 页为
  $ E_2^(p,q) = H^p (Y,R^q pi_* cal(F)) $
  收敛到 $H^(p+q) (X,cal(F))$. 称之为#strong[Leray谱序列] (Leray spectral sequence).
]

这个谱序列的存在性显然是 Grothendieck复合函子谱序列的一个特例.

== 松层

#definition(title:[松层])[
  拓扑空间 $X$ 上的层 $cal(F)$ 被称为#strong[松的] (flasque), 若对于任意开集 $U subset X$ 和任意开集 $V$ 包含 $U$, 则限制态射 $cal(F)(V) -> cal(F)(U)$ 是满射. 也就是说, 松层的局部截面总能提升到更大的开集上.
]

#theorem[
  设 $(X,cal(O)_X)$ 是赋环空间,
  $ 0 --> cal(F)' --> cal(F) --> cal(F)'' --> 0 $
  是 $cal(O)_X$-模层正合列, 若 $cal(F)'$ 是flasque的, 则对任意开集 $U$,
  $ 0 --> cal(F)'(U) --> cal(F)(U) --> cal(F)''(U) --> 0 $
  是模的正合列.
]

#proof[
  正合的左边平凡成立, 下证满射, 因为 $cal(F)->cal(F)''$ 满, 给定 $s'' in cal(F)''(U)$, 由满射性 $s''$ 可局部提升, 也即对每个点 $x in U$, 存在开邻域 $W subset U$ 和 $t in cal(F)(W)$ 使得 $t |-> s''|_W$.

  考虑全体可能的开子集系
  $ cal(S) = {(V,s) : V subset U "open", s in cal(F)(V), s|->s''|_V} $
  赋予偏序
  $ (V,s) <= (V',s') <==> V subset V' and s'|_V =s $
  由于层的粘贴公理, 任意链 $(V_i,s_i)$ 都有上界 $(union V_i, s)$, 由Zorn引理,
  $ exists (V,s) "maximal" $
  下证 $V=U$. 若非, 存在 $x in U \\ V$, 由于 $s''$ 在局部可提升, 取 $x$ 的开邻域 $W subset U$ 以及 
  $ t in cal(F)(W) $
  使得
  $ t |-> s''|_W $
  在交集 $V inter W$ 上, $s$ 和 $t$ 都提升到同一个截面 $s''$, 所以它们的差
  $ t|_(V inter W) - s|_(V inter W) $
  落在核中, 即来自某个
  $ a in cal(F)'(V inter W) $
  因为$cal(F)'$ flasque, 限制
  $ cal(F)'(W) -> cal(F)'(V inter W) $
  满, 可取
  $ b in cal(F)'(W) $
  使得
  $b|_(V inter W)=a$
  将 $t$ 修正为
  $ t-b in cal(F)(W) $
  那么在 $V inter W$ 上
  $ (t-b)|_(V inter W) = t|_(V inter W) -a = s|_(V inter W) $
  从而 $s$ 和 $t-b$ 可以粘贴成一个定义在 $V union W$ 上的截面
  $ tilde(s) in cal(F)(V union W) $
  并且其仍然提升
  $ s''|_(V union W) $
  但是 $x in W$ 且 $x in.not V$ 所以
  $ V union W $
  严格大于 $V$ 与极大性矛盾. 从而 $V=U$. 于是存在 $s in cal(F)(U)$ 提升 $s''$. 明所欲证.
]

#theorem[
  设 $(X,cal(O)_X)$ 是赋环空间,
  $ 0 --> cal(F)' --> cal(F) --> cal(F)'' --> 0 $
  正合, 若$cal(F)'$ flasque, 则 $cal(F)$ 是flasque的当且仅当 $cal(F)''$ 是flasque的.
]

#proof[
  去任意开集包含
  $ V subset U $
  要证明
  $ cal(F)''(U) --> cal(F)''(V) $
  满射, 取
  $ s'' in cal(F)''(V) $
  将前一个定理应用于开集 $V$, 存在
  $ s in cal(F)(V) $
  映到 $s''$, 因为 $cal(F)$ flasque, $s$ 可以延拓到 $U$, 即存在
  $ t|_V = s $
  将 $t$ 打到 $cal(F)''(U)$ 得到
  $ t'' in cal(F)''(U) $
  那么
  $ t''|_V = s'' $
  所以 $cal(F)''(U)->cal(F)''(V)$ 满, 因此 $cal(F)''$ flasque.

  Conversely, 取任意开集包含
  $ V subset U $
  要证
  $ cal(F)(U) --> cal(F)(V) $
  满射, 取
  $ s in cal(F)(V) $
  令其在 $cal(F)''(V)$ 中的像为 $s'' in cal(F)''(V)$, 因为 $cal(F)''$ flasque, $s''$ 可以延拓到 $U$, 即存在
  $ t'' in cal(F)''(U) $
  使得
  $ t''|_V = s'' $
  由上一个定理, 存在
  $ t in cal(F)(U) $
  映到 $t''$, 比较 $t|_V$ 和 $s$, 它们在 $cal(F)''(V)$ 中的像都是 $s''$, 因此它们的差
  $ s-t|_V $
  来自 $cal(F)'(V)$ 中的某个元素. 记
  $ a=s-t|_V in cal(F)'(V) $
  因为 $cal(F)'$ flasque, 存在
  $ b in cal(F)'(U) $
  使得
  $ b|_V=a $
  把 $b$ 看成 $cal(F)(U)$ 中的截面, 令
  $ tilde(t)=t+b in cal(F)(U) $
  那么限制到 $V$ 上,
  $ tilde(t)|_V = t|_V + b|_V = t|_V + a = s $
  从而 $s$ 可以提升到 $U$, 因此 $cal(F)$ flasque.
]

#lemma[
  设 $pi:X->Y$ 是拓扑空间的连续映射, $cal(F)$ 是 $X$ 上的flasque集合层, 则 $pi_* cal(F)$ 是 $Y$ 上的flasque集合层.
]

#proof[
  由前推的定义, 有
  $ (pi_* cal(F))(U)=cal(F)(pi^(-1)(U)) $
  我们要证明的是 $pi_*cal(F)$ flasque, 对任意开集包含
  $ Y subset U subset Y $
  需要证明的是限制
  $ (pi_*cal(F))(U) --> (pi_*cal(F))(V) $
  满, 这个映射就是
  $ cal(F)(pi^(-1)(U)) --> cal(F)(pi^(-1)(V)) $
  由于 $pi$ 连续, 开原像开, $pi^(-1)(U)$ 和 $pi^(-1)(V)$ 都是 $X$ 上的开集, 并且
  $ V subset U ==> pi^(-1)(V) subset pi^(-1)(U) $
  $cal(F)$ 是 $X$ 上的flasque层, 因此限制
  $ cal(F)(pi^(-1)(U)) --> cal(F)(pi^(-1)(V)) $
  满, 从而
  $ (pi_*cal(F))(U) --> (pi_*cal(F))(V) $
  满, 因此 $pi_*cal(F)$ flasque.
]

#theorem[
  设 $pi:X->Y$ 是赋环空间态射, $cal(F)$ 是一个 flasque $cal(O)_X$-模层, 则 $pi_* cal(F)$ 是 flasque 的 $cal(O)_Y$-模层.
]

#proof[
  略.
]

#theorem(title:[flasque蕴含 $Gamma$-acyclic])[
  设 $(X,cal(O)_X)$ 是赋环空间, $cal(F)$ 是 $X$ 上的 flasque $cal(O)_X$-模层, 则 $H^i (X,cal(F))=0$ 对所有 $i>0$ 都成立. 也就是说 flasque 模层是 $Gamma$-acyclic 的.
]

#proof[
  略.
]

== Shriek函子

为了证明内射层是flasque的,我们需要引入一个新的工具, 就是shriek函子.

除了总是作为 $pi_*$ 的左伴随, $pi^(-1)$ 有时也能作为右伴随. 这种情况发生在 $pi$ 是一个开嵌入的时候. 设
$ i:U arrow.r.hook Y $
是开嵌入, 

== 上同调的定义

#definition(title:[$cal(O)_X$-模层的上同调])[
  设 $(X,cal(O)_X)$ 是赋环空间, 则定义其上模层的 $i$ 阶#strong[上同调] (cohomology)
  $ H^i (X,cal(F)) = R^i Gamma(X,cal(F)) $
  这是一个函子 $"Mod"_(cal(O)_X) -> "Mod"_(Gamma(X,cal(O)_X))$.
]

前推函子也是左正合的, 我们固然也能定义其导出函子:

#definition(title:[导出前推])[
  设 $pi:(X,cal(O)_X)->(Y,cal(O)_Y)$ 是赋环空间态射, 我们可以定义
  $R^i pi_*:"Mod"_(cal(O)_X) -> "Mod"_(cal(O)_Y)$ 为
  $ R^i pi_* (cal(F)) = H^i (pi_* cal(I)^bullet) $
  其中 $cal(F)->cal(I)^bullet$ 是 $cal(F)$ 的内射解消.
]

=== 基本性质

显然, 我们通过导出函子定义的上同调显然满足我们在前面期望的性质 1-3. 我们来验证剩余的性质.

#theorem(title:[仿射空间的高阶上同调归零])[
  设 $X="Spec" A$ 是仿射概形, $cal(F)$ 是 $X$ 上的qcoh, 则 $H^i (X,cal(F))=0$ 对所有 $i>0$ 都成立.
] <affine-cohomology-vanishing>

#proof[
  显然有范畴等价
  $ "Mod"_A tilde.eq "QCoh"("Spec" A) $
  由 $M |-> tilde(M)$ 给出, 其逆就是
  $ Gamma(X,tilde(M))=M $
  立即得出这是一个正合函子, 因此 $R^i Gamma(X,-)=0$ 对所有 $i>0$ 都成立, 从而 $H^i (X,cal(F))=0$ 对所有 $i>0$ 都成立.
]

#theorem(title:[上同调关于底空间反变])[
  若 $pi:X -> Y$ 赋环空间态射, $cal(F)$ 是 $X$ 上的模层, 则有自然态射 $H^i (Y,pi_*cal(F)) -> H^i (X,cal(F))$, extending $Gamma (Y,pi_*cal(F)) -> Gamma(X,cal(F))$. 也就是说 $H^i$ 在某些意义上是关于底空间的反变函子.
]

#proof[
  因为
  $ Gamma(Y,pi_*cal(F))=(pi_*cal(F))(Y)=cal(F)(pi^(-1)(Y))=cal(F)(X)=Gamma(X,cal(F)) $
  所以零次上同调有同构
  $ H^0(Y,pi_*cal(F)) tilde.eq H^0(X,cal(F)) $
  现在作Leray谱序列
  $ E^(p,q)_2 = H^p (Y, R^q pi_*cal(F)) => H^(p+q)(X,cal(F)) $
  当 $q=0$ 时, $R^0 pi_*cal(F)=pi_*cal(F)$, 因此谱序列的 $q=0$ 行给出
  $ E^(i,0)_2 = H^i (Y,pi_*cal(F)) $
  而整个谱序列收敛到 $H^i(X,cal(F))$, 因此存在态射
  $ H^i (Y,pi_* cal(F)) = E^(i,0)_2 -> H^i (X,cal(F)) $
]

#theorem[
  若 $pi:X -> Y$ 是affine的概形, 且 $cal(F)$ 是概形上的qcoh, 则 $H^i (Y,pi_*cal(F)) ->^tilde H^i (X,cal(F))$ 是同构.
]

#proof[
  我们只需证明affine morphism对qcoh没有高阶导出前推, 即
  $ R^q pi_*cal(F) = 0, quad q > 0 $
  一旦知道这一点, Leray谱序列就退化在 $q=0$ 行, 从而 $H^i (Y,pi_*cal(F)) = E^(i,0)_2 = H^i (X,cal(F))$.

  下面证明 $R^q pi_*cal(F) = 0$ 对 $q>0$ 成立. 取 $Y$ 中任一仿射开集 $U="Spec" A$, 因为 $pi$ affine, $pi^(-1)(U)$ 也是仿射的, 设 $pi^(-1)(U)="Spec" B$, 因为 $cal(F)$ qcoh, 限制 $cal(F)|_(pi^(-1)(U))$ 是仿射概形上的的qcoh, 由 @affine-cohomology-vanishing 其高阶上同调消失
  $ H^q (pi^(-1)(U),cal(F))=0, quad q>0 $
  On the other hand, 高阶前推在仿射开集 $U$ 上局部由这些群控制:
  $ (R^q pi_* cal(F))(U)=H^q (pi^(-1)(U),cal(F)) $
  在这个情形下成立, 于是
  $ (R^q pi_* cal(F))(U)=0, quad q>0 $
  由于仿射开集构成 $Y$ 的一个基, $R^q pi_* cal(F)=0$ 对 $q>0$ 成立.
]

#definition(title:[Mayer-Vietoris列])[
  设 $X$ 是赋环空间, 且 $X=U union V$, $cal(F)$ 是其上的模层, 有短正合列
  $ 0 -> cal(F) -> cal(F)|_U plus.o cal(F)|_V -> cal(F)|_(U inter V) -> 0 $
  其中第三个箭头是差 $(s_U,s_V)|->s_U |_(U inter V) - s_V |_(U inter V)$ 诱导出长正合列
  $ dots.c -> H^i (X,cal(F)) ->H^i (U,cal(F)) plus.o H^i (V,cal(F)) -> H^i (U inter V,cal(F)) -> H^(i+1) (X,cal(F)) -> dots.c $
  称之为#strong[Mayer-Vietoris列] (Mayer-Vietoris sequence).
]

对于一个概形 $X$, 若 $X$ 满足任意两个仿射开集的交仿射, 则称之为strong[semi-separated]的. 容易验证 separated 蕴含 semi-separated.

#theorem[
  若semi-separated概形 $X$ 能被 $n$ 片仿射开集覆盖, 则 $H^i (X,cal(F)) = 0$ 对所有 $i >= n$ 和 $cal(F)$ 都成立. 特别地, 仿射概形的高阶上同调全为零.
]

#proof[
  归纳, 当 $n=1$ 时退化到 @affine-cohomology-vanishing, 假设结论对由 $n-1$ 个仿射开集覆盖的空间成立, 设
  $ X = U_1 union dots.c union U_n $
  记 $U=U_1 union dots.c union U_(n-1)$, $V=U_n$, 则 $X=U union V$, 其中 $U$ 由 $n-1$ 个仿射开集覆盖, $V$ 仿射. 交集为
  $ W := U inter V = (U_1 inter V) union dots.c union (U_(n-1) inter V) $
  由semi-separated, 每个 $U_i inter V$ 都是仿射的, 因此 $W$ 由 $n-1$ 个仿射开集覆盖. 接下来对 $U,V,W$ 应用归纳假设: $cal(F)$ 是qcoh, 限制到开子概形上仍然是qcoh, 因此
  $ H^i (U,cal(F)|_U)=0, quad i>=n-1 $
  由于 $V=U_n$ 仿射, 
  $ H^i (V,cal(F)|_V)=0, quad i>0 $
  $W$ 由 $n-1$ 个仿射开集覆盖,
  $ H^i (W,cal(F)|_W)=0, quad i>=n-1 $
  将这些信息带入 Mayer-Vietoris 列, 对于覆盖 $X=U union V$, 取 $i>=n$, 有一段
  $ H^(i-1) (W,cal(F)|_W) -> H^i (X,cal(F)) -> H^i (U,cal(F)|_U) plus.o H^i (V,cal(F)|_V) $
  因为 $i>=n$, 所以 $i-1>=n-1$, 因此
  $ H^i (U,cal(F))=0 $
  并且 $V$ 仿射, 因此
  $ H^i (V,cal(F))=0 $
  因此 $H^i (X,cal(F))$ 的前后项都为零, 从而 $H^i (X,cal(F))=0$.
]

#theorem(title:[上同调与滤过余极限交换])[
  设 $X$ 是qcqs的概形, $cal(F)_j$ 是 $X$ 上的一个 $cal(O)_X$-模层的滤过系统, 则
  $ H^i (X,varinjlim(j) cal(F)_j) = varinjlim(j) H^i (X,cal(F)_j) $
]

#proof[
  先证明仿射情形 $Y="Spec" A$, 显然其高阶归零, 并且
  $ Gamma (Y,varinjlim(j)cal(F)_j) = varinjlim(j) Gamma (Y,cal(F)_j) $
  平凡成立, 对于qcqs的概形 $X$, 存在有限的仿射开覆盖
  $ X = U_1 union dots.c union U_n $
  用Mayer-Vietoris列和Five Lemma进行归纳即可.
]

#corollary[
  设 $X$ 是qcqs的概形, $cal(F)$ 和 $cal(G)$ 是 $X$ 上的 $cal(O)_X$-模层, 则
  $ H^i (X,cal(F) plus.o cal(G)) = H^i (X,cal(F)) plus.o H^i (X,cal(G)) $
]

== Čech上同调的定义

我们可以在概形上定义一个非常具体的上同调, 就是Čech上同调.

#definition(title:[Čech上同调])[
  设 $X$ 是一个概形, $cal(F)$ 是 $X$ 上的 $cal(O)_X$-模层, 给定一个(通常取仿射)开覆盖
  $ frak(U) = {U_i}_(i in I) $
  我们定义 $cal(F)$ 关于 $frak(U)$ 的#strong[Čech复形] (Cech complex)为
  $ C^p (frak(U),cal(F)) = product_((i_0,...,i_p) in I^(p+1)) cal(F)(inter.big_(k=0)^(p)U_k) $
  每 $C^p$ 的元素是一族截面, 形如
  $ s=(s_(i_0...i_p) in cal(F)(U_(i_0...i_p))) $
  配备微分态射
  $
  d^p : C^p (frak(U),cal(F)) &-> C^(p+1) (frak(U),cal(F))\
  (s_(i_0...i_p))_(i_0...i_p)&|->(sum_(k=0)^(p+1) (-1)^k s_(i_0...hat(i_k)...i_(p+1))|_(U_(i_0...i_(p+1))))_(i_0...i_(p+1))
  $
  这个上链复形的上同调
  $ H^p (frak(U),cal(F)) := H^p (C^bullet (frak(U),cal(F))) $
  就被称为 $cal(F)$ 关于覆盖 $frak(U)$ 的#strong[Čech上同调] (Cech cohomology).
]

我们稍后将证明, 在qcqs概形上, Čech上同调与我们之前定义的上同调是同构的. 我们先验证一些基本的性质 (我们用 $U_I$ 来标记 $inter.big_(i in I)U_i$):

#theorem[
  设 $X$ 是qc+sep的概形. $frak(U)$ 是有限仿射开覆盖, $cal(F)$ 是qcoh, 则Čech上同调 $H^p (frak(U),cal(F))$ 与 $frak(U)$ 的选取无关.
] <cech-independence>

#proof[
  也就是说, 两个有限仿射开覆盖 $frak(U)$ 和 $frak(V)$ 诱导的复形拟同构.

  事实上, 我们只需要证明如下情形:
  $ |{V_i}| = |{U_i}| + 1 $
  这样的话对于任何两个有限仿射开覆盖 $frak(U)$ 和 $frak(V)$, 只需考虑有限加细诱导的
  $ H^i (frak(U),cal(F)) tilde.eq H^i (frak(U) union frak(V),cal(F)) tilde.eq H^i (frak(V),cal(F)) $
  即可. 具体地说, 我们将证明若 ${U_i}_(1<=i<=n)$ 是 $X$ 的一个覆盖, 而 $U_0$ 是另一个仿射开集, 则自然映射
  $ H^i_({U_i}_(0<=i<=n)) (X,cal(F)) --> H^i_({U_i}_(1<=i<=n)) (X,cal(F)) $
  是同构. 作下复形的短正合列
  $
  #diagram(
    node((1, 0), $0$),
    node((2, 0), $0$),
    node((3, 0), $0$),
    node((0, 1), $dots.c$),
    node((1, 1), $product_(|I| = i - 1 \ 0 in I) cal(F)(U_I)$),
    node((2, 1), $product_(|I| = i \ 0 in I) cal(F)(U_I)$),
    node((3, 1), $product_(|I| = i + 1 \ 0 in I) cal(F)(U_I)$),
    node((4, 1), $dots.c$),
    node((0, 2), $dots.c$),
    node((1, 2), $product_(|I| = i - 1) cal(F)(U_I)$),
    node((2, 2), $product_(|I| = i) cal(F)(U_I)$),
    node((3, 2), $product_(|I| = i + 1) cal(F)(U_I)$),
    node((4, 2), $dots.c$),
    node((0, 3), $dots.c$),
    node((1, 3), $product_(|I| = i - 1 \ 0 in.not I) cal(F)(U_I)$),
    node((2, 3), $product_(|I| = i \ 0 in.not I) cal(F)(U_I)$),
    node((3, 3), $product_(|I| = i + 1 \ 0 in.not I) cal(F)(U_I)$),
    node((4, 3), $dots.c$),
    node((1, 4), $0$),
    node((2, 4), $0$),
    node((3, 4), $0$),
    edge((1, 1), (2, 1), "->"),
    edge((2, 1), (3, 1), "->"),
    edge((1, 2), (2, 2), "->"),
    edge((2, 2), (3, 2), "->"),
    edge((1, 3), (2, 3), "->"),
    edge((2, 3), (3, 3), "->"),
    edge((1, 0), (1, 1), "->"),
    edge((2, 0), (2, 1), "->"),
    edge((3, 0), (3, 1), "->"),
    edge((1, 1), (1, 2), "->"),
    edge((2, 1), (2, 2), "->"),
    edge((3, 1), (3, 2), "->"),
    edge((1, 2), (1, 3), "->"),
    edge((2, 2), (2, 3), "->"),
    edge((3, 2), (3, 3), "->"),
    edge((1, 3), (1, 4), "->"),
    edge((2, 3), (2, 4), "->"),
    edge((3, 3), (3, 4), "->"),
    edge((0, 1), (1, 1), "->"),
    edge((0, 2), (1, 2), "->"),
    edge((0, 3), (1, 3), "->"),
    edge((3, 1), (4, 1), "->"),
    edge((3, 2), (4, 2), "->"),
    edge((3, 3), (4, 3), "->"),
  )
  $
  其中 $I$ 取遍 $I subset {0,...,n}$. 底下两行相对两个覆盖的Čech复形, 这是复形的短正合列, 由同调代数基本定理, 诱导出同调的长正合列. 现在我们希望最上面一行零调 (正合), 注意到 $X$ 是分离的, 从而 $U_0 inter U_j$ 仿射, 但是最上面一行的第 $i$ 个上同调恰好是
  $ H^(i-1)_(U_0 inter U_j)_(j>0)(U_0,cal(F)) $
  除了开头的 $i=0$ 情形, 其他情形都满足 $i-1>=0$, 因此上同调全为零, 从而最上面一行正合, 诱导出长正合列中间的态射. 由仿射概形的高阶Čech上同调消失, 我们会在下个定理验证:
]

#definition(title:[Čech解消])[
  设 $X$ 是一个概形, $cal(F)$ 是 $X$ 上的 $cal(O)_X$-模层, 给定一个(通常取仿射)开覆盖 $frak(U) = {U_i}_(i in cal(I))$, 那么复形
  $ 0 --> cal(F)(X) --> product_(|I|=1)cal(F)(U_I) --> product_(|I|=2)cal(F)(U_I) --> dots.c $
  (其中 $I subset cal(I)$ 取遍)是正合的, 称之为 $cal(F)$ 关于覆盖 $frak(U)$ 的#strong[Čech解消] (Cech resolution).
]

#proof[
  我们用一个技巧来证明正合, 上述的复形是下图表的中间一行:
  $
  #diagram(
    // 第一行
    node((0, 0), $0$),
    node((1, 0), $0$),
    node((2, 0), $product_(|I| = 1, 0 in I) cal(F)(U_I)$),
    node((3, 0), $product_(|I| = 2, 0 in I) cal(F)(U_I)$),
    node((4, 0), $dots.c$),
    // 第二行
    node((0, 1), $0$),
    node((1, 1), $cal(F)(X)$),
    node((2, 1), $product_(|I| = 1) cal(F)(U_I)$),
    node((3, 1), $product_(|I| = 2) cal(F)(U_I)$),
    node((4, 1), $dots.c$),
    // 第三行
    node((0, 2), $0$),
    node((1, 2), $cal(F)(X)$),
    node((2, 2), $product_(|I| = 1, 0 in.not I) cal(F)(U_I)$),
    node((3, 2), $product_(|I| = 2, 0 in.not I) cal(F)(U_I)$),
    node((4, 2), $dots.c$),
    // 横向箭头
    edge((0, 0), (1, 0), "->"),
    edge((1, 0), (2, 0), "->"),
    edge((2, 0), (3, 0), "->"),
    edge((3, 0), (4, 0), "->"),
    edge((0, 1), (1, 1), "->"),
    edge((1, 1), (2, 1), "->"),
    edge((2, 1), (3, 1), "->"),
    edge((3, 1), (4, 1), "->"),
    edge((0, 2), (1, 2), "->"),
    edge((1, 2), (2, 2), "->"),
    edge((2, 2), (3, 2), "->"),
    edge((3, 2), (4, 2), "->"),
    // 纵向箭头
    edge((1, 0), (1, 1), "->"),
    edge((1, 1), (1, 2), "->"),
    edge((2, 0), (2, 1), "->"),
    edge((2, 1), (2, 2), "->"),
    edge((3, 0), (3, 1), "->"),
    edge((3, 1), (3, 2), "->"),
  )
  $
  而最上面和最下面一行相同, 只不过平移了一格. 相应的长正合列说明中间一行是零调的.
]

#theorem(title:[仿射概形高阶Čech上同调消失])[
  设 $X="Spec" A$ 是仿射概形, $cal(F)$ 是 $X$ 上的qcoh, 则对于任意仿射开覆盖 $frak(U)$, $H^i (frak(U),cal(F))=0$ 对所有 $i>0$ 都成立.
]

#proof[
  略.
]

== Čech上同调与上同调的关系

#theorem(title:[上同调与Čech上同调的关系])[
  设 $X$ 是qc sep的概形, $cal(F)$ 是 $X$ 上的qcoh, 则Čech上同调和导出函子上同调同构.
  $ H^i_("Čech")(X,cal(F)) tilde.eq R^i Gamma(X,cal(F)) $
]

#lemma(title:["Čech-to-derieved"谱序列])[
  对任意开覆盖 $frak(U)$, 存在一个谱序列, $E^(p,q)_bullet$, 满足
  $ E^(p,q)_1 = product_((i_0,...,i_p) in I^(p+1)) H^q (U_(i_0,...,i_p),cal(F)) => H^(p+q) (X,cal(F)) $
]

我们来构造这个谱序列, 核心思路是 "取内射解消, 再对每一项作Čech复形". 设
$ 0 -> cal(F) -> cal(I)^0 -> cal(I)^1 -> dots.c $
是 $cal(F)$ 的内射解消, 对每个 $cal(I)^q$, 取其关于 $frak(U)$ 的Čech复形
$ C^p (frak(U),cal(I)^q) = product_(i_0,...,i_p) cal(I)^q (U_(i_0...i_p)) =: K^(p,q) $
图像上就是
$
#diagram(
  node((0, 0), $K^(0,2)$),
  node((1, 0), $K^(1,2)$),
  node((2, 0), $K^(2,2)$),
  node((3, 0), $dots.c$),
  node((0, 1), $K^(0,1)$),
  node((1, 1), $K^(1,1)$),
  node((2, 1), $K^(2,1)$),
  node((3, 1), $dots.c$),
  node((0, 2), $K^(0,0)$),
  node((1, 2), $K^(1,0)$),
  node((2, 2), $K^(2,0)$),
  node((3, 2), $dots.c$),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((0, 1), (1, 1), "->"),
  edge((1, 1), (2, 1), "->"),
  edge((2, 1), (3, 1), "->"),
  edge((0, 2), (1, 2), "->"),
  edge((1, 2), (2, 2), "->"),
  edge((2, 2), (3, 2), "->"),
  edge((0, 2), (0, 1), "->"),
  edge((0, 1), (0, 0), "->"),
  edge((1, 2), (1, 1), "->"),
  edge((1, 1), (1, 0), "->"),
  edge((2, 2), (2, 1), "->"),
  edge((2, 1), (2, 0), "->"),
)
$
其中横向态射是Čech微分, 纵向态射是内射解消的态射, 这是一个双复形, 接下来定义其总复形
$ "Tot"^n (K) = plus.o.big_(p+q=n) K^(p,q) $
总微分为
$ D = d_("Čech") + (-1)^p (d_("inj")) $
显然有 $D^2=0$. 这个双复形的谱序列就是我们要构造的谱序列, 即, 我们先对纵向取上同调, 得到 $E_1$, 固定 $p$, 竖直方向有
$ K^(p,bullet) = product_(i_0,...,i_p) cal(I)^bullet (U_(i_0...i_p)) $
又因为 $cal(I)^bullet$ 是 $cal(F)$ 的内射解消, 因此
$ H^q (cal(I)^bullet (U_(i_0...i_p))) = H^q (U_(i_0...i_p),cal(F)) $
这是因为 $Gamma(V,cal(I)^bullet|_V)=cal(I)^bullet (V)$. 从而竖直方向的上同调为
$ E^(p,q)_1 = H^q (K^(p,bullet)) = product_(i_0,...,i_p) (H^q (U_(i_0...i_p),cal(F))) $
这个 $E_1$ 页的微分就是Čech交错限制映射诱导, 因此
$ E^(p,q)_2 = H^p (E^(bullet,q)_1) $
就是对预层 $U |-> H^q (U,cal(F))$ 作Čech上同调, 由同调代数, 它收敛到总复形的上同调
$ E^(p,q) => H^(p,q)("Tot"^bullet (K)) $
下面说明 $H^n ("Tot"^bullet (K)) tilde.eq H^n (X,cal(F)) $. 容易验证, 对每个内射层 $cal(I)^q$, 取其解消的截面 (称之为增广Čech复形)
$ 0 --> cal(I)^q (X) --> C^0 (frak(U),cal(I)^q) --> C^1 (frak(U),cal(I)^q) --> dots.c $
是 $cal(I)^q (X)$ 的解消, 因此总复形 $"Tot"^bullet (K)$ 和全局截面复形 $Gamma(X,cal(I)^bullet)$ 都是 $cal(F)(X)$ 的解消, 从而它们拟同构. 这就证明了谱序列收敛到 $H^i (X,cal(F))$. 下面我们完成定理的证明.

#proof[
  因为 $X$ qc, 可以取有限仿射开覆盖 $frak(U) = {U_i}_(i in I)$. 因为 $X$ sep, 任意两个仿射开集的交仿射, 因此 $U_(i_0...i_p)$ 仿射, 因此有某个环使得
  $ U_(i_0...i_p) = "Spec" A_(i_0...i_p) $
  因为 $cal(F)$ qcoh, 限制到 $U_(i_0...i_p)$ 上仍然是qcoh, 因此
  $ H^q (U_(i_0...i_p),cal(F))=0, quad q>0 $
  也就是说, 覆盖 $frak(U)$ 是 $cal(F)$-cyclic的. 接下来作"Čech-to-derieved"谱序列, 由于上一步的消没, $E_1$-页只剩下一行
  $ E^(p,0)_q = product_(i_0,...,i_p) H^0 (U_(i_0...i_p),cal(F)) $
  但 $H^0 (U_(i_0...i_p),cal(F))=cal(F)(U_(i_0...i_p))$, 因此
  $ E^(p,0)_1 = product_(i_0,...,i_p) cal(F)(U_(i_0...i_p)) = C^p (frak(U),cal(F)) $
  而 $E_1$ 页的微分就是Čech微分, 因此
  $ E^(p,0)_2 = H^p (C^bullet (frak(U),cal(F))) = H^p (frak(U),cal(F)) $
  因为谱序列只有一行, 因此 $E_2$ 页就退化了, 从而
  $ H^p (frak(U),cal(F)) = E^(p,0)_2 => H^p (X,cal(F)) $
  由 @cech-independence, 证毕.
]

综上, 我们已经验证了在qc sep概形上, Čech上同调与我们之前定义的上同调同构. 我们将他们同一记作一个记号.

== 射影空间上的上同调

#theorem(title:[射影空间上的上同调])[
  1. $H^0 (PP^n_A,cal(O)(m))$ 在 $m>=0$ 时是秩 $binom(n+m,m)$ 的自由 $A$-模.
  2. $H^n (PP^n_A,cal(O)(m))$ 在 $m<=-n-1$ 时是秩 $binom(-m-1,-m-n-1)$ 的自由 $A$-模.
  3. 其他情况 $H^i (PP^n_A,cal(O)(m))=0$.
]

#proof[
  记
  $ S=A[x_0,...,x_n] $
  并取标准仿射开覆盖
  $ U_i=D_+(x_i) $
  由于这些交集仍然仿射, 由上一个定理, 我们只需要计算这个覆盖下的Čech复形. 对任意
  $ I subset {0,...,n} $
  有
  $ U_I = inter.big_(i in I) U_i $
  并且
  $ cal(O)(m)(U_I) = (S_(product_(i in I) x_i))_m $
  因此Čech复形就是
  $
    0 -> plus.o_i (S_(x_i))_m
      -> plus.o_(i<j) (S_(x_i x_j))_m
      -> dots.c
      -> (S_(x_0 dots.c x_n))_m -> 0
  $
  关键观察是: 这个复形可以按 Laurent 单项式拆开. 也就是说, 对每个整数向量
  $ a=(a_0,...,a_n) in ZZ^(n+1) $
  满足
  $ sum_i a_i=m $
  单项式
  $ x^a=x_0^(a_0) dots.c x_n^(a_n) $
  在哪些项中出现只由负指数的位置决定. 记
  $ N(a)={i : a_i<0} $
  那么 $x^a$ 会出现在 $U_I$ 的截面中当且仅当
  $ N(a) subset I $
  因此整个Čech复形是这些 $a$ 对应的小复形的直和.

  现在固定一个 $a$. 若 $N(a)=emptyset$, 则所有指数都非负, $x^a$ 已经是全局齐次多项式, 它只给 $H^0$ 贡献一个 $A$-基元. 这样的 $a$ 存在当且仅当 $m>=0$, 数量就是 $n+1$ 个非负整数和为 $m$ 的个数, 即
  $ binom(n+m,m) $
  若 $N(a)={0,...,n}$, 则 $x^a$ 只在最后一项
  $ (S_(x_0 dots.c x_n))_m $
  中出现, 因而只给最高维 $H^n$ 贡献一个 $A$-基元. 这等价于所有 $a_i<=-1$. 令
  $ b_i=-a_i-1>=0 $
  则
  $ sum_i b_i = -m-n-1 $
  所以这种 $a$ 存在当且仅当 $m<=-n-1$, 数量为
  $ binom(n+(-m-n-1),-m-n-1)=binom(-m-1,-m-n-1) $

  剩下的情形是
  $ emptyset != N(a) != {0,...,n} $
  此时 $x^a$ 对应的小复形就是一个非空真子集上方的Čech复形, 换句话说是一个单纯形的增广链复形平移后的一段, 因此零调. 这些单项式不贡献任何上同调.

  综上, 只有没有负指数的单项式留下 $H^0$, 只有所有指数都负的单项式留下 $H^n$, 中间情形全部消没. 这正是定理中三条结论.
]

== 更多定理

#theorem(title:[Serre消没定理, Serre有限性定理])[
  设 $A$ 是Noether环, $X$ 是射影 $A$-概形, $A$ 是Noether环, $cal(F)$ 是 $X$ 上的 coh, 并且那么对于 $m>>0$, 有
  $ H^i (X,cal(F)(m)) = 0 $
  对任意 $i>0$ 都成立, 其中 $cal(F)(m)=cal(F) times.o cal(O)(m)$ 是Serre扭. 同时 $H^i (X,cal(F))$ 是coherent的 $A$-模.
]

#proof[
  首先, 由于 $X$ 是射影 $A$-概形, 考虑嵌入
  $ j:X arrow.r.hook PP^n_A $
  且 $cal(O)_X (1)=j^*cal(O)_(PP^n_A)(1)$, 下面我们证明 
  $ H^i (X,cal(F)) tilde.eq H^i (PP^n_A,j_*cal(F)) $
  对任意开集 $V subset PP^n_A$ 有
  $ (j_*cal(F))(V) = cal(F)(V inter X) $
  零阶上同调显然有同构:
  $ H^0 (PP^n_A,j_*cal(F)) = (j_*cal(F))(PP^n_A) = cal(F)(X) = H^0 (X,cal(F)) $
  由于闭嵌入的前推是正合的, 
  $ R^q j_*cal(F) = 0, quad q>0 $
  由Leray谱序列, 
  $ H^p (PP^n_A,R^q j_* cal(F)) => H^(p+q) (X,cal(F)) $
  退化, 得到
  $ H^i (X,cal(F)) tilde.eq H^i (PP^n_A, j_*cal(F)) $
  因此我们只需要证明 $X=PP^n_A$ 的情形.

  我们将一般的凝聚层 $cal(F)$ 归约到有限多个 $cal(O)(a)$. 因为
  $ PP^n_A = "Proj" A[x_0,...,x_n] $
  且 $A$ Noetherian, 所以任意凝聚层 $cal(F)$ 都来自有限生成的分次模, 于是可以找到有限多个整数 $a_1,...,a_r$ 以及满射
  $ plus.o.big_(ell=1)^r cal(O)(a_ell) ->> cal(F) $
  记这个核为 $cal(K)_0$, 因为 $X$ Noetherian, coherent sheaf 的核依然 coherent. 从而有短正合列
  $ 0 --> cal(K)_0 --> cal(E)_0 --> cal(F) --> 0 $
  其中
  $ cal(E)_0 = plus.o.big_(ell=1)^r cal(O)(a_ell) $
  扭 $- times.o cal(O)(m)$ 是正合函子 ($cal(O)(m)$ 是flat的), 从而
  $ 0 --> cal(K)_0(m) --> cal(E)_0(m) --> cal(F)(m) --> 0 $
  正合, 因此有长正合列
  $ dots.c -> H^i (X,cal(E)_0(m)) -> H^i (X,cal(F)(m)) -> H^(i+1) (X,cal(K)_0(m)) -> H^(i+1) (X,cal(E)_0(m)) -> dots.c $
  而
  $ cal(E)_0(m) = plus.o.big_(ell=1)^r cal(O)(m+a_ell) $
  当 $m >> 0$ 时, 对所有 $i>0$ 有
  $ H^i (X,cal(E)_0(m)) = 0 $
  因此对 $i>0$, 长正合列给出同构
  $ H^i (X,cal(F)(m)) tilde.eq H^(i+1) (X,cal(K)_0(m)) $
  当 $m >> 0$ 时成立. 继续对 $cal(K)_0$ 作同样的处理, 得到
  $ H^(i+1) (X,cal(K)_0(m)) tilde.eq H^(i+2) (X,cal(K)_1(m)) $
  这里因为 $cal(K)_0$ 依然coherent, 所以同样可以找到有限多个整数 $b_1,...,b_s$ 以及满射
  $ cal(E)_1:=plus.o.big_(ell=1)^s cal(O)(b_ell) ->> cal(K)_0 $
  这个核就是 $cal(K)_1$. 我们可以反复定义
  $ 0 --> cal(K)_(r+1) --> cal(E)_(r+1) --> cal(K)_r --> 0 $
  同样手段得到
  $ H^i (X,cal(F)(m)) tilde.eq H^(i+r) (X,cal(K)_r (m)) $
  对于 $m>>0$. 但是 $PP^n_A$ 的标准仿射覆盖只有 $n+1$ 个开集, 所以Čech复形长度至多 $n$, 因此
  $ H^q (X,cal(G)) = 0, quad q > n $
  对任何qcoh层 $cal(G)$ 成立. 取 $r$ 足够大, 使得
  $ i+r>n $
  于是
  $ H^(i+r) (X,cal(K)_r (m))=0 $
  因此
  $ H^i (X, cal(F)(m)) = 0, quad i>0, m>>0 $
  就证明了上半部分.

  下面证明 $H^i (X,cal(F))$ 有限生成, 仍然考虑短正合列
  $ 0 --> cal(K) --> cal(E) --> cal(F) --> 0 $ 
  诱导长正合列
  $ dots.c -> H^i (X,cal(E)) -> H^i (X,cal(F)) -> H^(i+1) (X,cal(K)) -> H^(i+1) (X,cal(E)) -> dots.c $
  已知 $cal(E)$ 是有限个 $cal(O)(a_ell)$ 的直和, 因此 $H^i (X,cal(E))$ 是有限生成的 $A$-模. 我们从高到低归纳: 因为
  $ H^q (X,-)=0, quad q>n $
  所以高于 $n$ 的情形显然有限生成, 假设已经知道
  $ H^(i+1) (X,cal(K)) $
  有限生成, 则长正合列有
  $ H^i (X,cal(E)) --> H^i (X,cal(F)) --> H^(i+1) (X,cal(K)) $
  也就是说, $H^i (X,cal(F))$ 被夹在两个有限生成的 $A$-模之间, 由于 $A$ Noetherian, 有限生成模的子模有限生成, 从而 $H^i (X,cal(F))$ 也是有限生成的 $A$-模. 于是对所有 $i$ 都有 $H^i (X,cal(F))$ 是coherent的 $A$-模, 证毕.
]

#corollary[
  任何 $k$-射影概形的函数空间都是有限维的 $k$-向量空间.
]

#theorem[
  设 $pi:X->Y$ 是射影态射, $X$ 和 $Y$ 都是局部Noether概形, $cal(F)$ 是 $X$ 上的凝聚层, 则 $pi_* cal(F)$ 是 $Y$ 上的凝聚层.
]

#proof[
  嵌入 $PP^n_A$ 后由Serre有限性定理验证即可.
]

#corollary[
  设 $pi:X->Y$ 是射影态射, $X$ 和 $Y$ 都是局部Noether概形, 则 $pi$ 是projective且affine当且仅当其是finite的.
]

== $k$-概形的上同调

#theorem(title:[上同调保持基变换])[
  设 $X$ 是qc sep的 $k$-概形, $cal(F)$ 是 $X$ 上的qcoh, $K\/k$ 是域扩张, 则有自然同构
  $ H^i (X,cal(F)) times.o_k K <->^tilde H^i (X times_("Spec" k)"Spec" K, cal(F) times.o_k K) $
]

#proof[
  因为 $X$ qc, 所以可以取有限的仿射开覆盖
  $ frak(U) = {U_1,...,U_n} $
  又因为 $X$ sep, 任意两个仿射开集的交仿射, 因此 
  $ U_(i_0...i_p):= U_(i_0) inter ... inter U_(i_p) $
  仿射, 对于qcoh层 $cal(F)$, 考虑Čech复形
  $ C^p (frak(U),cal(F)) = product_(i_0,...,i_p) Gamma(U_(i_0...i_p),cal(F)) $
  令
  $ U_(i,K) := U_i times_("Spec" k)"Spec" K $
  那么 ${U_(i,K)}$ 是 $X_K := X times_("Spec" k)"Spec" K$ 的仿射开覆盖. 且
  $ U_(i_0,K) inter ... inter U_(i_p,K) = U_(i_0...i_p) times_("Spec" k)"Spec" K $
  从而基变换后的Čech复形为
  $ C^p (frak(U)_K, cal(F)_K) = product_(i_0,...,i_p) Gamma((U_(i_0...i_p))_K, cal(F)_K) $
  设 $U="Spec" A$ 是 $X$ 的一个仿射开集, 且
  $ cal(F)|_U = tilde(M) $
  其中 $M$ 是 $A$-模, 因为 $X$ 是 $k$-概形, $A$ 是 $k$-代数, 因此基变换后
  $ U_K = U times_("Spec" k)"Spec" K = "Spec" (A times.o_k K) $
  而
  $ cal(F)_K|_(U_K) = tilde(M times.o_k K) $
  所以
  $ Gamma(U_K,cal(F)_K) = M times.o_k K = Gamma(U,cal(F)) times.o_k K $
  结果拉回到有限交有
  $ C^p (frak(U),cal(F)) times.o_k K tilde.eq C^p (frak(U)_K,cal(F)_K) $
  且这个同构与Čech微分兼容, 从而诱导出复形同构, 由于 $K$ 是平坦的 $k$-代数, 基变换是正合的, 从而诱导出所求的上同调同构. 证毕.
]

== 同调维数与Grothendieck消失定理

#definition[
  设 $X$ 是概形, 定义 $X$ 的#strong[同调维数] (cohomological dimension) 为满足
  $ H^i (X,cal(F))=0, quad i>d $
  对任意qcoh层 $cal(F)$ 都成立的最小整数 $d$, 记作 $"cd"(X)=d$. 如果不存在这样的整数, 则定义同调维数为无穷大 $"cd"(X)=oo$.
]

对于同调维数, 我们有重要的Grothendieck消失定理

#theorem(title:[Grothendieck消失定理])[
  设 $X$ 是Noether拓扑空间, 则 $"cd"(X) <= dim(X)$.
]

#proof[
  对任意qcoh $cal(F)$, 构造
  $ cal(G) = product_(x in X) i_(x,*)cal(F)_x $
  其中 $i_x:{x} arrow.r.hook X$ 是点的嵌入, $cal(F)_x$ 是stalk.

  因为每个 $i_(x,*)cal(F)_x$ 都是skyscraper sheaf, 限制总是满射, 从而flasque, 乘积依然是flasque的, 从而有
  $ H^i (X,cal(G))=0, quad i > 0 $
  其次有自然单态射 $cal(F) arrow.r.hook cal(G)$, 这是因为在stalk上 $cal(F)_y -> cal(F)_y$ 至少包含一个分量 $cal(F)_y -> cal(F)_y$, 即恒等映射, 从而其为单射. 我们得到了短正合列
  $ 0 --> cal(F) --> cal(G) --> cal(Q) --> 0 $
  得到长正合列
  $ dots.c -> H^i (X,cal(G)) -> H^i (X,cal(Q)) -> H^(i+1) (X,cal(F)) -> H^(i+1) (X,cal(G)) -> dots.c $
  因为 $cal(G)$ 上同调消失, 从而
  $ H^i (X,cal(Q)) tilde.eq H^(i+1) (X,cal(F)) $
  而 $cal(Q)$ 的support严格包含 $cal(F)$ 的support, 因此
  $ dim "Supp" cal(Q) < dim "Supp" cal(F) <= dim(X) $
  这是因为在 $"Supp" cal(F)$ 最高维泛点处, $cal(F)->cal(G)$ 已经是同构, 商 $cal(Q)$ 在那里消失, 商层的support只能在更低维的地方. 因此我们可以归纳地证明对于 $delta(cal(F))=dim "Supp" cal(F)$,
  $ H^i (X,cal(F))=0, quad i > delta(cal(F)) $
  若 $delta(cal(F))<0$, 则 $cal(F)=0$, 上同调自然消失. 对于 $r:=delta(cal(F))$, 取上面的
  $ 0 -> cal(F) -> cal(G) -> cal(Q) -> 0 $
  其中 $cal(G)$ flasque且 $delta(cal(Q))<r$. 对 $i>r$ 有
  $ H^i (X,cal(F)) tilde.eq H^(i-1) (X,cal(Q)) $
  但
  $ i-1 > r-1 >= delta(cal(Q)) $
  由归纳假设, $H^(i-1) (X,cal(Q))=0$, 从而 $H^i (X,cal(F))=0$. 证毕.
]


Riemann--Roch是上同调理论的一个典型应用, 它给出了一个计算曲面上线丛的空间维数的公式. 这个定理在代数几何中有着非常重要的地位, 因为它可以用来证明很多关于曲线和曲面性质的结果.

下面, 我们默认我们在域 $k$ 上工作 ($"Sch"_(\/k)$).

== Euler示性数

#lemma(title:[Serre])[
  $PP^n$ 上的任意凝聚层 $cal(G)$ 都能被有限个Serre扭曲的线丛生成, 即存在 $m_1,...,m_r$ 使得
  $ plus.o.big_(j=1)^r cal(O)_(PP^n)(m_j) ->> cal(G) $
] <coherent-epi-lemma>

#proof[
  令
  $ S=k[x_0,...,x_n] $
  我们知道 $PP^n="Proj" S$ 上的任意凝聚层 $cal(E)$ 都可以写成某个有限生成分次 $S$-模 $M$ 的伴随层
  $ cal(E) tilde.eq tilde(M) $
  由于 $M$ 有限生成, 存在有限个齐次元素
  $ e_1,...,e_r in M $
  生成 $M$, 设 $d_j = deg e_j$. 每个齐次生成元 $e_j in M_(d_j)$ 给出一个分次 $S$-模同态
  $ S(-d_j) --> M $
  其中 $1 |-> e_j$, $S(-d_j)$ 是分次平移. 这些同态和起来给出满射
  $ plus.o.big_(j=1)^r S(-d_j) ->> M $
  取伴随层就得到了满射
  $ plus.o.big_(j=1)^r tilde(S(-d_j)) ->> tilde(M) $
  而
  $ tilde(S(-d_j)) tilde.eq cal(O)_(PP^n)(-d_j) $
  令 $m_j = -d_j$, 就得到了所求.
]

#lemma[
  设 $X$ 是射影 $k$-概形, $cal(F)$ 是 $X$ 上的凝聚层, 则 $h^i (X,cal(F))=dim_k H^i (X,cal(F))$ 有限.
]

#proof[
  因为 $PP^n_k$ 可以由 $n+1$ 个仿射开集覆盖, 所以对任意凝聚层 $cal(G)$ 有
  $ H^i (PP^n_k,cal(G))=0, quad i>n $
  现在对 $i$ 从 $n$ 向 $0$ 下降归纳. 假设已经知道对任意凝聚层 $cal(G)$, 有 $H^(i+1)(PP^n_k,cal(G))$ 有限维. 由 @coherent-epi-lemma, 存在 $m_1,...,m_r$ 使得
  $ plus.o.big_(j=1)^r cal(O)_(PP^n_k)(m_j) ->> cal(G) $
  记
  $ cal(E) = plus.o.big_(j=1)^r cal(O)_(PP^n_k)(m_j) $
  以及
  $ cal(K) = ker(cal(E) ->> cal(G)) $
  则有短正合列
  $ 0 -> cal(K) -> cal(E) -> cal(G) -> 0 $
  得到长正合列片段
  $ H^i (PP^n_k,cal(E)) -> H^i (PP^n_k,cal(G)) -> H^(i+1)(PP^n_k,cal(K)) $
  两边都是有限维: 因为
  $ H^i (PP^n,cal(E)) = H^i (PP^n,plus.o.big_(j=1)^r cal(O)_(PP^n_k)(m_j)) = plus.o.big_(j=1)^r H^i (PP^n,cal(O)_(PP^n_k)(m_j)) $
  而 $H^(i+1) (PP^n_k,cal(K))$ 有限维是归纳假设. 因此 $H^i (PP^n_k,cal(G))$ 有限维.

  对任意射影 $k$-概形 $X$, 存在一个嵌入
  $ i : X arrow.r.hook PP^n_k $
  令
  $ cal(G) = i_* cal(F) $
  闭嵌入是有限态射, 因此 $i_* cal(F)$ 仍然是 $PP^n_k$ 上的凝聚层, 且闭嵌入的前推是正合的, 不会改变上同调, 证毕.
]

下面我们可以定义Euler示性数的概念

#definition(title:[Euler示性数])[
  设 $X$ 是射影 $k$-概形, $cal(F)$ 是 $X$ 上凝聚层, 则定义 $cal(F)$ 的#strong[Euler示性数] (Euler characteristic) 为
  $ chi(X,cal(F)) := sum_(i=0)^(dim X) (-1)^i h^i (X,cal(F)) $
]

也就是, 层上同调的交错维数和. 对于大于 $dim X$ 的 $i$, 由Grothendieck消失定理, $H^i (X,cal(F))=0$, 因此上面的和是有限的.

#theorem(title:[射影空间线丛的Euler示性数])[
  总有
  $ chi(PP^n_k,cal(O)(m)) = ((m+1)(m+2)...(m+n))/(n!) $
]

#proof[
  Trivial.
]

通常情况下, 我们很难直接计算上同调群的维数, 但是Euler示性数往往更容易计算. 而Euler示性数往往也是个更稳定的不变量.

#lemma[
  设有限维 $k$-线性空间的有限长度正合列
  $ 0 -> V_1 -> V_2 -> ... -> V_N -> 0 $
  则其维数的交错和为 $0$, 即
  $ sum_(j=1)^N (-1)^j dim_k V_j = 0 $
]

#proof[
  我们知道对于 $f:V->W$, 有
  $ dim V = dim ker f + ker im f $
  简单的代数计算就可以得到.
]


#theorem(title:[Euler示性数的加性])[
  设 $X$ 是射影 $k$-概形
  $ 0 --> cal(F) --> cal(G) --> cal(H) --> 0 $
  是 $X$ 上凝聚层的一个短正合列, 则
  $ chi(X,cal(G)) = chi(X,cal(F)) + chi(X,cal(H)) $
]

#proof[
  设
  $ 0 --> cal(F) --> cal(G) --> cal(H) --> 0 $
  是 $X$ 上凝聚层的一个短正合列, 则有长正合列
  $ 0 -> H^0 (X,cal(F)) -> H^0 (X,cal(G)) -> H^0 (X,cal(H)) -> H^1 (X,cal(F)) -> ...$
  并且这个正合列有限长. Grothendieck消失定理保证了 $H^i (X,-)$ 的消失, 因此正合列在 $i>dim X$ 时就结束了. 由上一个引理, 这个有限维空间的有限长度正合列的维数交错和为 $0$, 因此
  $ sum_(i=0)^(dim X) (-1)^i dim_k h^i (X,cal(G)) = sum_(i=0)^(dim X) (-1)^i dim_k h^i (X,cal(F)) + sum_(i=0)^(dim X) (-1)^i dim_k h^i (X,cal(H)) $
  也就是
  $ chi(X,cal(G)) = chi(X,cal(F)) + chi(X,cal(H)) $
]

#corollary[
  设 $X$ 是射影 $k$-概形
  $ 0 -> cal(F)_1 -> cal(F)_2 -> ... -> cal(F)_N -> 0 $
  是 $X$ 上凝聚层的一个有限长度正合列, 则
  $ sum_(j=1)^N (-1)^j chi(X,cal(F)_j) = 0 $
]

== 射影曲线上线丛的Riemann--Roch

我们先来看看射影曲线上线丛的Riemann--Roch.

#definition(title:[除子的次数])[
  设
  $ D = sum_(p in C_"reg") a_p [p] $
  是域 $k$ 上射影曲线 $C$ 上的一个除子, 其中 $a_p in ZZ$, 并且只有有限个 $a_p$ 不为 $0$. $C_"reg"$ 是 $C$ 的正则维数零的点. 那么定义 $D$ 的#strong[度数] (degree) 为 
  $ deg D = sum a_p deg p $
  而 $deg p$ 是点 $p$ 的度数, 也就是 $kappa(p)$ 作为 $k$-域扩张的扩张次数
  $ deg p = [kappa(p):k] $
]

#theorem(title:[射影曲线上线丛的Riemann--Roch, Ver 1])[
  设 $C$ 是域 $k$ 上的射影曲线, $D$ 是 $C$ 上的一个除子, 则
  $ chi(C,cal(O)_C (D)) = deg D + chi(C,cal(O)_C) $
] <RR-1>

#proof[
  首先, 对于一个正则闭点 $p in C$, 有闭子概形正合列
  $ 0 --> cal(O)_C (-p) --> cal(O)_C --> i_(p,*)kappa(p) --> 0 $
  后面是支撑在 $p$ 上, 纤维为 $kappa(p)$ 的skyscraper层. 而闭点在 $C$ 中是有效Cartier除子, 因此 $cal(O)_C (-p) = cal(I)_p$ 其中 $cal(I)_p$ 是 $p$ 的理想层.

  现在, 我们将这个正合列张量上 $cal(O)_C (D)$, 因为 $cal(O)_C (D)$ 是线丛 (从而是局部自由层), 张量积是正合的, 因此得到正合列
  $ 0 --> cal(O)_C (D-p) --> cal(O)_C (D) --> i_(p,*)kappa(p) times.o cal(O)_C (D) --> 0 $
  而 $i_(p,*)kappa(p) times.o cal(O)_C (D)$ 在 $p$ 处作为 $kappa(p)$-线性空间是一维的, 从而
  $ H^0 (C,i_(p,*)kappa(p) times.o cal(O)_C (D)) tilde.eq kappa(p) $
  高阶上同调为零, 因此
  $ chi(C,i_(p,*)kappa(p) times.o cal(O)_C (D)) = dim_k kappa(p) = deg p $
  由Euler示性数的加性, 有
  #neq($ chi(C,cal(O)_C (D)) = chi(C,cal(O)_C (D-p)) + deg p $) <RR-proof-1>
  这是核心的归纳公式.

  我们归纳地证明原结论, 记
  $ N(sum_(p in C_"reg") a_p [p]) = sum_(p in C_"reg") |a_p| $
  先考虑 $N(D)=0$ 的情形, 也就是 $D=0$, 此时公式变成
  $ chi(C,cal(O)_C) = deg 0 + chi(C,cal(O)_C) $
  显然成立, 下面假设结论对于所有满足 $N(E)<N(D)$ 的除子 $E$ 都成立. 证明 $D$ 的情形.

  #emph[Situation 1.] $D$ 中存在一个点 $p$ 使得 $a_p>0$. 那么 $D-p$ 的 $N$ 值比 $D$ 小, 对 $D-p$ 运用归纳假设
  $ chi(C,cal(O)_C (D-p)) = deg (D-p) + chi(C,cal(O)_C) $
  由 @RR-proof-1, 
  $ chi(C,cal(O)_C (D)) = deg (D-p) + chi(C,cal(O)_C) + deg p $
  而 $deg (D-p) + deg p = deg D$, 结论成立.

  #emph[Situation 2.] $D$ 中的每个非零系数点 $p$ 都满足 $a_p < 0$. 若 $D != 0$, 存在 $p$ 使得 $a_p < 0$, 令 $E=D+p$, 则 $N(E)<N(D)$ 且 $D=E-p$, 对 $E$ 运用 @RR-proof-1,
  $ chi(C,cal(O)_C (E)) = chi(C,cal(O)_C (D)) + deg p $
  由归纳假设
  $ chi(C,cal(O)_C (E)) = deg E + chi(C,cal(O)_C) $
  因此
  $ chi(C,cal(O)_C (D)) = deg E - deg p + chi(C,cal(O)_C) $
  而 $deg E - deg p = deg D$, 结论成立.

  综上, 结论成立.
]

由于任何正规曲线上的线丛 $cal(L)$ 都可以写成 $cal(O)_C (D)$ 的形式, 因此上面的定理非常的强大. 下面的定义我们稍后还会推广:

#definition(title:[曲线线丛的次数])[
  设 $cal(L)$ 是 $k$-射影曲线 $C$ 上的一个线丛, 则定义 $cal(L)$ 的#strong[度数] (degree) 为
  $ deg_C cal(L) = chi(C,cal(L)) - chi(C,cal(O)_C) $
]

#theorem[
  总是有
  $ deg D = deg_C cal(O)_C (D) $
]

#proof[
  由 @RR-1 即得.
]

#theorem[
  设 $C$ 是域 $k$ 上的射影曲线, $cal(L)$ 是 $C$ 上的一个线丛, $s$ 是 $cal(L)$ 在 $C$ 上的非零有理截面, 并且 $s$ 在 $C$ 的所有奇异点处正则, 令 $D="div" s$, 则 $deg cal(L) = deg D$. 特别地, 在正则的情况, 一个线丛的次数可以通过计算任意一个有理截面的零点和极点得到.
]

#proof[
  设
  $ D = "div" (s) = sum_(p in C_"reg") v_p (s)[p] $
  因为 $s$ 是 $cal(L)$ 的非零有理截面, 所以它在 $C$ 的稠密开集上给出一个平凡化
  $ cal(O)_C arrow.dashed cal(L), quad 1 |-> s $
  在每个正则闭点附近, $cal(L)$ 是线丛, 可以取局部生成元 $e$, 写成 $s=f e$, 其中 $f$ 是一个局部有理函数. 于是
  $ v_p (s) = v_p (f) $
  与 $e$ 的选择无关, 现在证明 $cal(L) tilde.eq cal(O)_C (D)$. 局部看, 若 $s=f e$, 且
  $ v_p (s) = a $
  那么 $f$ 在 $p$ 处有 $a$ 阶零点或 $-a$ 阶极点. 令 $t$ 是 $cal(O)_(C,p)$ 的局部参数, 则可写
  $ f = t^a u $
  其中 $u in cal(O)^times_(C,p)$. 而除子 $D$ 在 $p$ 处的系数是 $a$, 因此 $cal(O)_C (D)$ 在 $p$ 附近可以由形式上运行 $a$ 阶零点/极点的生成元描述. 也就是说, $cal(O)_C (D)_p$ 由一个局部生成元 $t^(-a)$ 生成, 映射 $cal(O)_C (D) -> cal(L)$ 由 $t^(-a) |-> u e$ 给出. 这个映射在 $p$ 附近是同构的, 因此在 $C$ 的每个点附近都是同构的, 证毕.
]

#corollary[
  $deg:"Pic" C --> ZZ$ 是Abel群同态.
]

此时, 我们记 $"Pic"^d C := deg^(-1)(d)$ 为 $d$ 的原像, 也就是 $C$ 上度数为 $d$ 的线丛的集合. 这不总是一个群, $"Pic"^0 C$ 总是是一个Abel群, 是 $"Pic" C$ 的子群. 每个 $"Pic"^d C$ 是 $"Pic"^0 C$ 在 $"Pic" C$ 中的陪集.

== 算术亏格

接下来, 我们定义算术亏格的概念, 这是一个非常重要的概形不变量

#definition(title:[算术亏格])[
  设 $X$ 是纯维数 $n$ 的 $k$-射影概形, 则定义 $X$ 的#strong[算术亏格] (arithmetic genus) 为
  $ p_a (X) := (-1)^n (chi(X,cal(O)_X)-1) $
]

对于代数闭域上的整射影曲线, $h^0 (X,cal(O)_X)=1$, 从而 $p_a (X)=h^1 (X,cal(O)_X)$. 从而我们可以改写Riemann--Roch定理为:

#theorem(title:[射影曲线上线丛的Riemann--Roch, Ver 2])[
  设 $C$ 是域 $k$ 上的射影曲线, $cal(L)$ 是 $C$ 上的一个线丛, 则
  $ h^0 (C,cal(L)) - h^1 (C,cal(L)) = deg cal(L) - p_a (C) + 1 $
] <RR-2>

这是Riemann--Roch最经典的形式之一.

亏格也有非常强大的几何意义, 当 $C$ 是复射影曲线时, 其解析化对象就是一个紧致Riemann面, 其亏格就是这个Riemann面的拓扑亏格. 因此, 亏格为零的曲线就是拓扑上是球面的曲线, 亏格为一的曲线就是拓扑上是环面的曲线, 以此类推. 此时亏格就是这个曲面洞的数量, 这和代数拓扑中的亏格定义是一致的.

== 凝聚层的度

#definition(title:[凝聚层的秩和度])[
  设 $C$ 是域 $k$ 上的整射影曲线, $cal(F)$ 是其上的凝聚层, 定义 $cal(F)$ 的#strong[秩] (rank) 为
  $ "rank" cal(F) = "rank"_eta cal(F) = "dim"_(kappa(eta)) cal(F)(eta) = "dim"_(kappa(eta)) cal(F)_eta\/frak(m)cal(F)_eta $
  同时, 定义 $cal(F)$ 的#strong[度数] (degree) 为
  $ deg cal(F) = chi(C,cal(F)) - ("rank" cal(F)) dot chi(C,cal(O)_C) $
  这显然和线丛的度数定义兼容, 因为线丛的秩是 $1$.
]

#theorem(title:[度的可加性])[
  设
  $ 0 --> cal(F) --> cal(G) --> cal(H) --> 0 $
  是 $C$ 上凝聚层的一个短正合列, 则
  $ chi(C,cal(G)) = chi(C,cal(F)) + chi(C,cal(H)) $
]

#proof[
  Trivial.
]

我们回顾一下绕层的概念:

#definition(title:[绕层])[
  设 $X$ 是概形, $cal(F)$ 是一个 $cal(O)_X$-模层, 若在每个点 $x in X$, $cal(F)_x$ 都是 $cal(O)_(X,x)$-绕模, 则称 $cal(F)$ 是 $X$ 上的一个#strong[绕层] (torsion sheaf).
]

在整概形上, 我们可以给出等价的描述, 即 $cal(F)$ 绕当且仅当对任意 $U subset X$, $forall s in cal(F)(U)$, 都存在 $0 != f in cal(O)_X (U)$ 使得 $f s=0$. 更为结构化地, 对于一个整概形 $X$, 绕 $cal(F)$ 的绕子层定义为
$ cal(F)_"tor" = ker(cal(F)-->cal(F)times.o_(cal(O)_X)K(X)) $
$cal(F)$ 是绕的当且仅当 $cal(F)_"tor" = cal(F)$. 下面依旧默认讨论凝聚层:

#lemma[
  若 $X$ 是整概形, $cal(F)$ 是凝聚层, 则 $cal(F)$ 绕当且仅当 $"rank"cal(F)=0$.
] <lemma-torsion-1>

#lemma[
  若 $X$ 是整概形, $cal(F)$ 是拟凝聚层, 则 $cal(F)$ 绕当且仅当 $cal(F)_eta=0$, 其中 $eta$ 是 $X$ 的泛点.
] <lemma-torsion-2>

#theorem[
  设 $C$ 是域 $k$ 上的整射影曲线, $cal(F)$ 是 $C$ 上的一个绕凝聚层, 则 $deg cal(F)>=0$, 为零当且仅当 $cal(F)=0$.
]

#proof[
  由 @lemma-torsion-1, $cal(F)$ 绕当且仅当 $"rank" cal(F)=0$. 因此
  $ deg cal(F) = chi(C,cal(F)) $
  只需证明 $chi(C,cal(F))>=0$. 且为零当且仅当 $cal(F)=0$. 因为 $C$ 是整曲线, $cal(F)$ 是凝聚绕层, 由 @lemma-torsion-2, 其在泛点处为零, 于是 $"Supp"(cal(F))$ 不包含泛点. 而 $C$ 是一维Noether的, $"Supp" (cal(F))$ 只能是有限多个闭点, 也就是说存在有限个闭点
  $ p_1,...,p_r in C $
  使得
  $ "Supp" cal(F) subset {p_1,...,p_r} $
  因此 $cal(F)$ 是零维支撑的凝聚层, 没有高阶上同调, 从而
  $ chi(C,cal(F)) = h^0 (C,cal(F)) >= 0 $
  当 $cal(F)=0$ 时, $chi(C,cal(F))=0$. 反过来, 当 $chi(C,cal(F))=0$ 时, $h^0 (C,cal(F))=0$, 因此 $cal(F)=0$, 证毕.
]

== 层和除子的长度

在Abel范畴中, 我们可以很自然地定义长度的概念\

#definition(title:[长度])[
  设 $bold(A)$ 是一个Abel范畴, $A$ 是 $bold(A)$ 中的一个对象, 定义 $A$ 的#strong[长度] (length) 为 $A$ 的一个有限长度Jordan--Hölder序列的长度. 也就是
  $ 0 = A_1 subset.neq ... subset.neq A_n = A $
  这个滤链的最大长度, 记作 $ell(A)$.
]

我们可以很自然地定义模, 层的长度, 一个非常好的记法是类比 $lg$ (真有人用这个符号表示长度), 因为他和对数有很类似的性质, 例如将积 (直和) 转化为和, 并且在短正合列中可加.

#definition(title:[除子的长度])[
  设 $D$ 是概形 $C$ 上的一个除子, 定义
  $ L(D) = {f in K (C)^times : "div"(f) + D >= 0 } union {0} $
  为一个线性空间, 其维数叫做 $D$ 的#strong[长度] (length), 即
  $ ell(D) := dim_k L(D) $
]

这两个是#strong[截然不同的概念], 前者是Abel范畴中对象的长度, 后者是一个除子 $D$ 的长度, 也就是满足 $D$ 的零点和极点条件的有理函数的维数. 通常没有 $ell(D) = ell(O_C (D))$, 这只是一个记号碰撞.

显然若 $C$ 是光滑射影曲线, 则 $L(D) = H^0 (C,cal(O)_C (D))$, 因此 $ell(D) = h^0 (C,cal(O)_C (D))$. 下面我们证明Riemann--Roch定理的另一个版本:

#theorem(title:[射影曲线上线丛的Riemann--Roch, Ver 3])[
  设 $C$ 是域 $k$ 上的射影曲线, $D$ 是 $C$ 上的一个除子, 则
  $ ell(D) - ell(K_C - D) = deg D - p_a (C) + 1 $ 
]
== Hilbert函数定义和基本性质

注意, 对于任何射影概形 $X subset PP^n$, 我们都可以定义 $cal(O)(1)$ 为射影嵌入的拉回层
$ cal(O)_X (1) = i^* cal(O)_(PP^n_k) (1) $
因此下面的定义实际上依赖于嵌入的选取, 而非只有概形.

#definition(title:[Hilbert函数])[
  设 $X subset PP^n$ 是一个射影 $k$-概形, $cal(F)$ 是一个凝聚层, 定义
  $ h_cal(F)(m) = h^0 (X,cal(F)(m)) $
  其中 $cal(F)(m)=cal(F)times.o cal(O)(m)$ 是Serre扭. 称之为 $cal(F)$ 的#strong[Hilbert函数] (Hilbert function). 特别地, $cal(O)_X$ 的Hilbert函数被称为 $X$ 的Hilbert函数, 记为 $h_X (m)$.
]

接下来, 我们将说明Hilbert函数"大概是一个多项式", 首先我们需要一些前置:

#theorem(title:[Serre消失定理])[
  对任何射影 $k$-概形 $X$ 和凝聚层 $cal(F)$, 对于 $m>>0$, 有
  $ H^i (X,cal(F)(m)) = 0 $
  对全体 $i>0$ 成立, 其中 $cal(F)(m)$ 是Serre扭.
] <serre-vanishing>

#proof[
  证明略. 参考其他笔记.
]

#theorem[
设 $cal(F)$ 是一个射影 $k$-概形 $X$ 上的凝聚层, 则 $chi(X,cal(F)(m))$ 是一个次数为 $dim "Supp" cal(F)$ 的 $QQ$-系数多项式.
]

#proof[
  首先, 我们先把问题放到 $PP^N_k$ 上, 令
  $ i:X arrow.hook PP^N_k $
  是射影闭嵌入, 所以
  $ H^q (X,cal(F)(m)) tilde.eq H^q (PP^N_k,i_* cal(F)(m)) $
  且 $i_*cal(F)(m) tilde.eq (i_*cal(F))(m)$. 我们可以将 $cal(F)$ 看成 $PP^n_k$ 上的凝聚层, 只需证明
  $ chi(PP^N_k,cal(F)(m)) $
  是多项式.

  由Hilbert Syzygy, 凝聚层 $cal(F)$ 存在一个有限的解消
  $ 0 -> cal(E)_r -> ... -> cal(E)_1 -> cal(E)_0 -> cal(F) -> 0 $
  其中每个 $cal(E)_j$ 都是有限个线丛的直和
  $ cal(E)_j = plus.o.big_alpha cal(O)_(PP^N)(a_(j,alpha)) $
  由于Euler示性数在正合列中可加, 对上面的有限正合列张量 $cal(O)(m)$, 有
  $ chi(PP^N,cal(F)(m)) = sum_j (-1)^j chi(PP^N,cal(E)_j (m)) $
  而
  $ cal(E)_j (m) = plus.o.big_alpha cal(O)_(PP^N) (m+a_(j,alpha)) $
  所以
  $ chi(PP^N,cal(E)_j (m)) = sum_alpha chi(PP^n,cal(O)(m+a_(j,alpha))) $
  我们知道
  $ chi(PP^N,cal(O)(t)) = ((t+1)(t+2)...(t+N))/(N!) $
  是关于 $t$ 的 $N$ 次多项式, 有限个多项式加减也是多项式, 从而 $chi(PP^N,cal(F)(m))$ 是关于 $m$ 的 $QQ$-系数多项式. 下面我们证明其次数为 $dim "Supp" cal(F)$.

  证明次数的思路是, 对于射影空间, 用超平面切一次, 维数降 $1$. 对于多项式作一次差分 $f(x)-f(x-1)$, 次数降 $1$. 记 $r=dim "Supp" cal(F)$, 当 $r=0$ 时, $cal(F)$ 只支持在有限多个点上, 张量 $cal(O)(m)$ 不改变其在这些点上的长度, 从而 $chi(X,cal(F)(m))$ 是常数多项式, 次数零.

  对于 $r>0$, 假设对于 $<r$ 的情况结论成立, 取一个足够一般的超平面 $H subset PP^N$ 不包含 $"Supp" cal(F)$ 的任何 $r$-维不可约分支, 设 $H$ 由线性函数 $ell$ 定义, 那么乘以 $ell$ 可以给出短正合列
  $ 0 --> cal(F)(m-1) -->^(dot ell) cal(F)(m) --> cal(F)_H (m) --> 0 $
  此处 $cal(F)_H$ 是支撑在超平面截面 $"Supp" cal(F) inter H$ 上的凝聚层. 显然
  $ dim "Supp" cal(F)_H = r-1 $
  对短正合列作用 $chi$ 有
  $ chi(X,cal(F)(m)) = chi(X,cal(F)(m-1)) + chi(X,cal(F)_H (m)) $
  也就是
  $ P_cal(F)(m)-P_cal(F)(m-1)=P_(cal(F)_H)(m) $
  左边是 $P_cal(F)$ 的差分 $Delta P_cal(F)$, 由归纳假设, $P_(cal(F)_H)(m)$ 是 $r-1$ 次的多项式, 丛而
  $ P_cal(F)(m)-P_cal(F)(m-1) $
  是 $r-1$ 次多项式, 由差分的性质, $P_cal(F)(m)$ 是 $r$ 次多项式.
]

由Serre消失定理 (@serre-vanishing), 下面的定义是正确的:

#definition(title:[Hilbert多项式])[
  对于 $m>>0$, $h_cal(F)(m)$ 是关于 $m$ 的 $dim "Supp" cal(F)$ 次多项式, 称之为层 $cal(F)$ 的#strong[Hilbert多项式] (Hilbert polynomial). 特别地, $h_X (m)$ 是关于 $m$ 的 $dim X$ 次多项式. 记作 $P_cal(F)(m)$.
]

显然, 继承Euler示性数的性质, Hilbert多项式在短正合列里是可加的.

#theorem(title:[Hilbert多项式的基本性质])[
  设 $cal(F)$ 是射影 $k$-概形 $X$ 上的凝聚层, 则
  1. $P_cal(F)(m)$ 是关于 $m$ 的 $dim "Supp" cal(F)$ 次多项式.
  2. 对于短正合列
     $ 0 --> cal(F)' --> cal(F) --> cal(F)'' --> 0 $
     有
     $ P_cal(F)(m) = P_(cal(F)')(m) + P_(cal(F)'')(m) $
  3. 若 $P_cal(F) = 0$, 则 $cal(F)=0$.
]

#proof[
  略.
]

#example[
  射影空间 $PP^n$ 的Hilbert多项式是
  $ P_(PP^n)(m) = binom(m+n,m) $
  对于次数为 $d$ 的超曲面 $H subset PP^n$, 伴随 $i : H arrow.hook PP^n$ 闭嵌入, 有闭子概形正合列
  $ 0 --> cal(O)_(PP^n)(-d) --> cal(O)_(PP^n) --> i_* cal(O)_H --> 0 $
  从而
  $ P_H (m) = P_(PP^n)(m) - P_(PP^n)(m-d) = binom(m+n,n) - binom(m+n-d,n) $
]

#example[
  求twisted cubic曲线
  $ nu : PP^1 arrow.hook PP^3, quad [s:t] |-> [s^3:s^2 t:s t^2:t^3] $
  的Hilbert多项式.
]

#proof[
  设其概形论像为 $C = nu(PP^1) subset PP^3$, 我们只需计算 $chi(C,cal(O)_C (m))$. 我们知道
  $ nu : PP^1 -->^tilde C $
  是同构, 又 $C subset PP^3$, 有
  $ cal(O)_C (1) = cal(O)_(PP^3)(1)|_C $
  拉回到 $PP^1$ 有
  $ nu^*cal(O)_C (1) = nu^*cal(O)_(PP^3)(1) $
  而 $nu$ 是由四个三次齐次多项式给出的, 从而对应的线丛是 $cal(O)_(PP^1)(3)$, 因此
  $ nu^*cal(O)_C (1) tilde.eq cal(O)_(PP^1)(3) $
  于是
  $ nu^*cal(O)_C (m) tilde.eq cal(O)_(PP^1) (3 m) $
  因为 $C tilde.eq PP^1$, 有
  $ chi(C,cal(O)_C (m)) = chi(PP^1,cal(O)_(PP^1)(3 m)) = 3 m + 1 $
]

更一般地, 我们有如下的结论:

#theorem(title:[Veronese嵌入的Hilbert多项式])[
  考虑 $PP^n$ 的 $d$-次Veronese嵌入
  $ nu_d : PP^n arrow.hook PP^(binom(n+d,d)-1) $
  由完全线性系 $|cal(O)_(PP^n)(d)|$ 给出, 即
  $ [x_0:...:x_n] |-> [...:x^(a_0)_0...x^(a_n)_n:...] $
  满足 $a_0+...+a_n=d$. 则
  $ P_(nu_d (PP^n)) (m) = binom(d m+n,n) $
] <veronese-hilbert>

#proof[
  类似的讨论可以得出, 此处略.
]

#theorem[
  设
  $ X arrow.hook^i Y arrow.hook PP^n_k $
  是连续的闭嵌入, 则:
  1. 当 $m>>0$ 时, $P_X (m)<=P_Y (m)$.
  2. 若 $m>>0$ 时, $P_X (m)=P_Y (m)$, 则 $X=Y$.
]

#proof[
  设 $cal(I):=cal(I)_(X\/Y)$ 是理想层, 则有短正合列
  $ 0 --> cal(I) --> cal(O)_Y --> i_*cal(O)_X --> 0 $ 
  张量 $cal(O)(m)$ 得到短正合列
  #neq($ 0 --> cal(I)(m) --> cal(O)_Y (m) --> i_*cal(O)_X (m) --> 0 $)<hilbert-ideal-sequence-1>

  由于 $i$ 是闭嵌入, 上同调不变
  $ H^q (Y,i_* cal(O)_X (m)) tilde.eq H^q (X,cal(O)_X (m)) $

  先证明1. 作长正合列
  $ 0 -> H^0 (Y,cal(I)(m)) -> H^0 (Y,cal(O)_Y (m)) -> H^0 (Y,i_*cal(O)_X (m)) -> H^1 (Y,cal(I)(m)) -> ... $
  由Serre消失定理, $m>>0$ 时, $H^1 (Y,cal(I)(m))=0$, 从而
  $ 0 -> H^0 (Y,cal(I)(m)) -> H^0 (Y,cal(O)_Y (m)) -> H^0 (Y,i_*cal(O)_X (m)) -> 0 $
  是短正合列, 于是
  $ h^0 (Y,cal(O)_Y (m)) = h^0 (Y,cal(I)(m)) + h^0 (Y,i_*cal(O)_X (m)) $
  因此
  $ h^0 (X,cal(O)_X (m)) <= h^0 (Y,cal(O)_Y (m)) $
  当 $m>>0$ 时, Hilbert函数等于Hilbert多项式, 从而
  $ P_X (m)<=P_Y (m) $

  再证明2. 由 @hilbert-ideal-sequence-1, 有
  $ chi(Y,cal(O)_Y (m)) = chi(Y,cal(I)(m)) + chi(Y,i_*cal(O)_X (m)) $
  也就是
  $ P_Y (m) = P_cal(I) (m) + P_X (m) $
  若 $P_Y (m)=P_X (m)$, 则 $P_cal(I) (m)=0$, 由Hilbert多项式的基本性质, 得到 $cal(I)=0$, 从而 $X=Y$.
]

== 度数

我们可以从Hilbert多项式中提取很多几何不变量

#definition(title:[概形的度数])[
  设 $X$ 是 $n$ 维的射影 $k$-概形, 其#strong[度数] (degree) 定义为其Hilbert多项式的最高次项 $m^n$ 项系数乘以 $n!$, 即
  $ deg(X) = n! dot.c a_n, quad P_X (m) = a_n m^n + ... + a_1 m + a_0 $
]

#theorem[
  度数一定是一个非负整数, 并且 $deg(X)=0 <=> X=emptyset$
]

#proof[
  这是一个初等代数事实, $P_X (m) in QQ[m]$ 是 $n$ 次多项式, 且 $f(m)$ 对所有充分大的 $m$ 取整数值. 我们要证明最大次项系数 $a_n$ 是 $1/n!$ 的整数倍.

  对 $n$ 作归纳, $n=0$ 时 $P_X (m) = a_0$ 是常数, 若其在充分大的 $m$ 取整数值, 则 $a_0 in ZZ$, 从而 $deg(X)=0! dot.c a_0 = a_0 in ZZ$. 假设结论对 $<n$ 成立, 令
  $ P_X (m) = a_k m^k + a_(k-1)m^(k-1) + ... $
  是 $k$ 次多项式, 且 $P_X (m)$ 对充分大的 $m$ 取整数值. 作差分
  $ Delta P_X (m) = P_X (m) - P_X (m-1) $
  因为 $P_X (m+1)$ 和 $P_X (m)$ 对充分大的 $m$ 取整数值, 从而 $Delta P_X (m)$ 对充分大的 $m$ 也取整数值. 因为
  $ (m+1)^n - m^n = n m^(n-1) + "Lower degrees" $
  所以
  $ Delta P_X (m) = a_n ((m+1)^n - m^n) + ... = n a_n m^(n-1) + "Lower degrees" $
  因此 $Delta P_X (m)$ 是 $n-1$ 次多项式, 首项系数为 $n a_n$, 由归纳假设, $(n-1)! dot n a_n in ZZ$, 从而 $deg(X) = n! dot.c a_n in ZZ$.
]

#theorem[
  设 $H$ 是 $PP^n$ 中度数为 $d$ 的超曲面 ($d$ 次), 则 $deg(H)=d$.
]

#proof[
  回顾超曲面的Hilbert多项式
  $ P_H (m) = binom(m+n,n) - binom(m+n-d,n) $
  硬算即可.
]

#remark[
  回顾曲线上局部自由层的度的概念
  $ deg cal(E) = chi(C,cal(F)) - ("rank" cal(F)) dot chi(C,cal(O)_C) $
  对于线丛, 就是
  $ deg cal(L) = chi(C,cal(L)) - chi(C,cal(O)_C) $
]

我们回顾Riemann--Roch的一个形式

#theorem(title:[射影曲线上线丛的Riemann--Roch])[
  设 $C$ 是域 $k$ 上的射影曲线, $cal(L)$ 是 $C$ 上的一个线丛, 则
  $ h^0 (C,cal(L)) - h^1 (C,cal(L)) = deg cal(L) - p_a (C) + 1 $
] 

其中 $p_a (C)$ 是算术亏格, 定义为
$ p_a (C) = 1 - chi(C,cal(O)_C) $

#theorem[
  设一个正则曲线 $C$ 通过一个次数 $d$ 的可逆层嵌入射影空间中, 那么在这个嵌入下, $deg(C)=d$.
]

#proof[
  这个嵌入由 $cal(L)$ 给出, 也就是说 $cal(O)_C (1) tilde.eq cal(L)$, 因此
  $ cal(O)_C (m) = cal(O)_C (1)^(times.o m) tilde.eq cal(L)^(times.o m) $
  Hilbert多项式定义为
  $ P_C (m) = chi(C,cal(O)_C (m)) = chi(C,cal(L)^(times.o m)) $
  由Riemann--Roch定理, 有
  $ P_C(m) = chi(C,cal(L)^(times.o m)) = deg cal(L)^(times.o m) + chi(C,cal(O)_C) = m d + chi(C,cal(O)_C) $
  是一个一次多项式, 且 $m$ 的系数为 $d$, 证毕.
]

#remark[
  正则假设只是为了方便, 事实上可以去掉这个假设.
]

#theorem(title:[Veronese嵌入的度数])[
  设 $nu_d : PP^n arrow.hook PP^(binom(n+d,d)-1)$ 是 $d$-次Veronese嵌入, 则 $deg nu_d (PP^n) = d^n$.
]

#proof[
  Veronese嵌入的Hilbert多项式为
  $ P_(nu_d (PP^n)) (m) = binom(d m+n,n) $
  其最高次项为 $d^n m^n/n!$, 从而
  $ deg nu_d (PP^n) = n! dot.c d^n/n! = d^n $
]

== Bézout定理

Bézout定理是一个非常深刻且重要的代数几何定理

#theorem(title:[Bézout定理])[
  设 $X subset PP^n_k$ 是一个至少 $1$ 维的射影概形, $H=V_+ (f)$ 是 $PP^n_k$ 中的超曲面, 并且 $H$ 不包含 $X$ 的任何伴随点, 则
  $ deg (H times_(PP^n) X) = deg H dot deg X $
  P.S. 当 $X$ 是既约概形时, 没有嵌入点, 条件可改为 $H$ 不包含 $X$ 的任何不可约分量.
]

#proof[
  因为 $H$ 由次数为 $e$ 的齐次多项式 $f$ 定义, 从而在 $X$ 上, $f$ 给出乘法映射
  $ cal(O)_X (-e) -->^(dot f) cal(O)_X $
  这个操作可以理解为 $cal(O)_X (-e) -> cal(O)_X (-e) times.o cal(O)_X (e)$, $f$ 是 $cal(O)_X (e)$ 的全局截面. 通过自然的同构看成 $g |-> g f$. 条件 $H$ 不包含 $X$ 的任何伴随点, 等价于说这个映射是单射的. 于是有短正合列
  $ 0 --> cal(O)_X (-e) -->^(dot f) cal(O)_X --> cal(O)_(H times_(PP^n) X) --> 0 $
  最后的商正是 $X$ 上模掉 $f$ 后的结构层, 也就是 $H times_(PP^n) X$ 的结构层. 张量 $cal(O)(m)$ 得到短正合列
  $ 0 --> cal(O)_X (m-e) -->^(dot f) cal(O)_X (m) --> cal(O)_(H times_(PP^n) X) (m) --> 0 $
  对这个短正合列作用 $chi$ 有
  $ chi(X times_(PP^n) H,cal(O)_(X times_(PP^n) H) (m)) = chi(X,cal(O)_X (m)) - chi(X,cal(O)_X (m-e)) $
  也就是Hilbert多项式满足
  $ P_(X times_(PP^n) H)(m) = P_X (m) - P_X (m-e) $
  因为 $dim X=r>1$, 设
  $ P_X (m) = (deg X)/(r!) m^r + "Lower degree" $
  那么
  $ P_X (m-e) = (deg X)/(r!) (m-e)^r + "Lower degree" $
  从而
  $ P_X (m) - P_X (m-e) = (deg X)/(r!) (m^r-(m-e)^r) + "Lower degree" $
  展开有
  $ (m-e)^r = m^r - r e m^(r-1) + "Lower degree" $
  因此
  $ m^r - (m-e)^r = r e m^(r-1) + "Lower degree" $
  从而
  $ P_(X times_(PP^n) H)(m) = (deg X)/(r!) r e m^(r-1) + "Lower degree" $
  即
  $ P_(X times_(PP^n) H)(m) = (e deg X)/(r-1)! m^(r-1) + "Lower degree" $
  于是
  $ deg (X times_(PP^n) H) = (r-1)! dot.c (e deg X)/(r-1)! = e deg X $
  而 $e=deg H$, 证毕.
]

下面的定理形式上也和Bézout定理很像

#theorem[
  设 $X$ 和 $Y$ 是 $PP^n_k$ 的两个 $d$-维闭子概形, 且没有 $d$-维公共的不可约分支, 则
  $ deg(X union Y) = deg X + deg Y $
]

#proof[
  只需考虑正合列
  $ 0 --> cal(O)_(X union Y) --> cal(O)_X plus.o cal(O)_Y --> cal(O)_(X inter Y) --> 0 $
  即可. 详细证明略.
]

#remark[
  记忆. 概形相交, 度数相乘; 概形并, 度数相加.
]

== 重访算术亏格

我们知道

#definition(title:[算术亏格])[
  设 $X$ 是纯维数 $n$ 的 $k$-射影概形, 则定义 $X$ 的#strong[算术亏格] (arithmetic genus) 为
  $ p_a (X) := (-1)^n (chi(X,cal(O)_X)-1) $
]

对于代数闭域上的整射影曲线, $h^0 (X,cal(O)_X)=1$, 从而 $p_a (X)=h^1 (X,cal(O)_X)$. 我们将这个概念和Hilbert多项式联系起来. 注意到
$ P_X (0) = chi(X,cal(O)_X) $
是 $X$ 的一个内在不变量, 不依赖射影嵌入. 并且他和算术亏格的关系为
$ p_a (X) = (-1)^n (P_X (0)-1) $
这对古人来说肯定非常神奇, 因为他们一开始对于Hilbert函数的概念通过分次环的维数定义, 他们并没有算术亏格的概念, 他们发现这个函数最终是一个多项式, 并且这个多项式在 $0$ 处的值是一个不变量, 并且在紧致黎曼面的情况下, 这就是拓扑亏格!

#theorem[
  设超曲面 $V_+ (f) = X subset PP^n_k$ 具有度数 $<=n$, 则 $chi(X,cal(O)_X)=1$.
]

#proof[
  依旧考虑正合列
  $ 0 --> cal(O)_(PP^n)(-d) -->^(dot f) cal(O)_(PP^n) --> cal(O)_X --> 0 $
  对这个短正合列作用 $chi$ 有
  $ chi(X,cal(O)_X) = chi(PP^n,cal(O)_(PP^n)) - chi(PP^n,cal(O)_(PP^n(-d))) $
  而
  $ chi(PP^n,cal(O)_(PP^n)) = 1 $
  只需证明
  $ chi(PP^n,cal(O)_(PP^n(-d))) = 0 $
  我们知道
  $ chi(PP^n,cal(O)_(PP^n(-d))) = P_(PP^n)(-d) = binom(-d+n,n) $
  因为 $1<=d<=n$, 有一项是 $-d+d=0$, 从而 $binom(-d+n,n)=0$, 证毕.
]

= 微分

何谓微分? 微分是一个你在数学分析里就学过的概念. 在代数几何里, 空间不再和经典的微积分相关. 代数几何的空间是由环来反向编码的:
$ X = Spec B $
此时, 点, 函数, 切空间以及导数的信息都藏在环 $B$ 里. 要定义空间上的微分, 我们需要先找出环上的导数是什么. 

== 导子

导子可谓是代数中对于求导的第一层抽象化, 或许你已经在微分几何中接触过这个概念. 它是一个线性映射, 就像任何微分一样. 并且还满足Leibniz律

#definition(title:[导子])[
  固定一个环同态 $A->B$, $M$ 是一个 $B$-模. 所谓 *$A$-导子* (derivation) 是一个态射
  $ D:B->M $
  满足:

  1. $D(b+b')=D(b)+D(b)'$.
  2. $D(b b')=b D(b')+b' D(b)$.
  3. $D(a)=0$ 对任意 $a in A$, 视作环同态下的像.
] <def-derivation>

几个显然的结论:

#theorem[导子是 $A$-线性的, 即 $D(a b)=a D(b)$. $a in A$.]
#proof[
  由Leibniz律, $D(a b)=a D(b)+b D(a)=a D(b)$.
]

固定环同态 $A->B$ 后, 导子构成一个范畴

#definition[
  设 $A->B$ 是环同态. 定义范畴 $Der_A (B)$ 如下:

  - 对象是二元组 $(M,D)$, 其中 $M$ 是一个 $B$-模, $D:B->M$ 是一个 $A$-导子.
  - $(M,D)$ 到 $(N,E)$ 的态射是交换图表
  #align(center, diagram({
	node((-1, -1), [$M$])
	node((1, -1), [$N$])
	node((0, 0), [$B$])
	edge((0, 0), (-1, -1), [$D$], label-side: left, "->")
	edge((0, 0), (1, -1), [$E$], label-side: right, "->")
	edge((-1, -1), (1, -1), [$phi$], label-side: left, "->")
  }))
]

当固定一个 $M$ 的时候, $Der_A (B,M)$ 代表所有从 $B$ 到 $M$ 的 $A$-导子. $Der_A (B,M)$ 对于逐点加法和标量乘法构成典范的 $B$-模结构.

#theorem(title:[导子的链式法则])[
  对于环同态 $A->^f B->^g C$, 有正合列
  $ 0 --> Der_B (C,M) -->^(D|->D) Der_A (C,M) -->^(D|->D compose g) Der_A (B,M) $
]

#proof[
  第一个映射显然是单射. 考察第二个位置
  $ D in ker(Der_A (C,M) -> Der_A (B,M)) $
  当且仅当对所有 $b in B$ 有 $D(g(b))=0$. 但这正是说 $D$ 在 $B$ 的像上为零, 也就是说 $D$ 是 $B$-导子, 从而 $D in Der_B (C,M)$, 因此
  $ ker(Der_A (C,M) -> Der_A (B,M)) = Der_B (C,M) $
]

== Kähler微分

接下来要定义的Kähler微分是"对函数求导"的纯代数化版本.

#definition(title:[Kähler微分])[
  设 $A->B$ 是环同态. *Kähler微分* (Kähler differential) $(Omega_(B\/A),d)$ 就是 $Der_A (B)$ 的始对象. 
] <def-kahler-differential>

我们也可以用Yoneda嵌入来identify Kähler微分. 也就是说, 函子
#neq($ Der_A (B,-):bold("Mod")_B -> bold("Set") $) <eq-der-functor>
可以被 $Omega_(B\/A)$ 表示. 也就是说
$ Der_A (B,M) tilde.eq Hom_B (Omega_(B\/A),M) $

下面我们证明Kähler微分的存在性. 这本质就是证明 @eq-der-functor 中的函子可表.

#proof[
  我们先取自由的 $B$-模
  $ F = plus.o.big_(b in B) B dot d b $
  作
  $ Omega_(B\/A) = F\/R, quad R="span" { d (b+b')-d b-d b', d(b b')-b d b' - b' d b, d a } $
  令 $D:B->M$ 是任意的 $A$-导子, 其中 $M$ 是一个 $B$-模. 由于 $Omega_(B\/A)$ 由符号 $d b$ 生成, 我们可以定义一个 $B$-模态射
  $ phi : Omega_(B\/A) -> M $
  唯一可能的定义就是
  $ phi(d b)=D(b) $
  显然是良定义的, 因为 $D$ 满足同样的关系, 于是 $phi$ 存在并且满足
  $ phi compose d = D $
  唯一性也立即成立, 因为 $Omega_(B\/A)$ 由所有的 $d b$ 生成, 任何 $phi$ 若满足 $phi compose d = D$, 那么就必须满足 $phi(d b)=D(b)$, 于是 $phi$ 是唯一的. 这就证明了 $Omega_(B\/A)$ 是 $Der_A (B)$ 的始对象, 也就是Kähler微分的存在性.
]

#remark[
  上述论证也给出了 $Omega_(B\/A)$ 的一个显示构造. 也就是
  $ Omega_(B\/A) := (plus.o.big_(b in B) B dot d b) slash mat(d(b+b')-d b-d b';d(b b')-b d b'-b' d b;d a) $
]

#theorem[
  若 $A$ 是有限生成的 $B$-代数, 那么 $Omega_(A\/B)$ 是一个有限生成的 $A$-模.
  若 $A$ 是有限表示的 $B$-代数, 那么 $Omega_(A\/B)$ 是一个有限表示的 $A$-模.
]

== Kähler微分的例子

我们先来看一些例子

=== 取商

若 $A=B\/I$, 那么 $Omega_(A\/B)=0$. 这是因为对所有的 $a in A$, 都有 $d a = 0$.

注意这里的意思是相对环 $B$ 没有Kähler微分, 并不表示整体结构上没有Kähler微分. 例如, 考虑 $A=k[x]\/(x^2)$, 那么 $Omega_(A\/k)=A dot d x$ 是一个自由的 $A$-模, 但是 $Omega_(A\/k[x])=0$.

=== 添加自由变量

若 $A=B[x_1,...,x_n]$, 那么
$ Omega_(A\/B) = A d x_1 plus.o ... plus.o A d x_n $
即使我们添加任意多个变元, 这个结论依然适用. 背后的几何直观也很合理: 因为仿射 $n$-空间的余切丛确实是秩 $n$ 的自由模.

=== 显式例子: 一条仿射平面直线

考虑仿射平面 $AA^2_k$ 中的直线 $y^2=x^3-x$, 其中 $"char" k != 2$. 令
$ A = k[x,y] \/ (y^2-x^3+x) $
我们知道, 微分模 $Omega_(A\/k)$ 由 $d x$ 和 $d y$ 生成. 并且满足 $d (y^2-x^3+x) = 0$, 也就是
$ 2 y d y = (3 x^2 - 1) d x $
因此在 $y!=0$ 的开集上, $d x$ 是一个生成元, 因为 $d y$ 可以用 $d x$ 表示. 于是我们得到在 $y!=0$ 的地方, $Omega_(A\/k)$ 同构于平凡的线丛.

类似地, 在 $3 x^2 - 1 != 0$ 的开集上, $d y$ 是一个生成元, 这两个开集覆盖整条曲线, 因为 $y=0$ 会给出 $x^3-x=0$, 也就是 $x=0,plus.minus 1$. 而在这些点上, $3 x^2 - 1 != 0$. 因此我们得到
$ tilde(Omega)_(A\/k) $
是一个线丛, 也就是余切丛.

#theorem[
  设
  $ A = B[x_1,...,x_n]\/(f_1,...,f_n) $
  那么
  $ Omega_(A\/B) = (plus.o.big_i A d x_i) \/ (A d f_1 + ... + A d f_n) $
  这可以解释成Jacobian矩阵 $J:A^(plus.o r)->A^(plus.o n)$ 的余核.
]

$Omega$ 和余切空间的联系如下

#theorem(title:[微分层与余切空间的关系, 仿射版本])[
  设 $B$ 是有限型 $k$-代数, $frak(m)subset B$ 是即大理想, 其剩余域为 $k$, 那么存在 $k$-线性空间同构
  $ frak(m)\/frak(m)^2 -->^~ Omega_(B\/k) times.o_B k $
  其中右边的 $k$ 通过同构 $k-->^~ B\/frak(m)$ 视作一个 $B$-模.
]

#proof[
  定义这个映射为
  $ a mod frak(m)^2 |-> d a times.o 1 $
  显然良定义. 我们构造一个 $k$-导子 $D:B->frak(m)\/frak(m)^2$. 对任意 $b in B$, 由于 $B\/frak(m) tilde.eq k$, 存在唯一的 $lambda in k$ 使得 $b-lambda in frak(m)$. 定义
  $ D(b) = b - lambda mod frak(m)^2 $
  也就是说, $D(b)$ 是取 $b$ 的"一阶无穷小部分". 容易验证 $D$ 是 $k$-导子. 由Kähler微分的泛性质
  $ Der_k (B,M) tilde.eq Hom_B (Omega_(B\/k),M) $
  代入 $M=frak(m)\/frak(m)^2$, 导子 $D$ 对应了唯一的 $B$-线性映射
  $ Omega_(B\/k) -> frak(m)\/frak(m)^2 $
  满足 $d b|-> D(b)$. 由于 $frak(m)$ 作用在 $frak(m)\/frak(m)^2$ 上为 $0$, 这个映射进一步因子化为
  $ psi : Omega_(B\/k) times.o_B k -> frak(m)\/frak(m)^2 $
  最终验证 $phi,psi$ 互逆即可.
]

#theorem[
  设 $X$ 是代数闭域上的有限型概形, 则从 $X$ 的闭点到 $ZZ^(>=0)$ 的函数
  $ p |-> dim T_p X $
  是对Zariski拓扑上半连续的.
]

=== 局部化

设 $T$ 是 $B$ 的一个乘法封闭子集, $A = T^(-1)B$, 那么
$ Omega_(A\/B) = 0 $
这是因为根据商法则 (容易证明), 若 $a = b/t$, 则
$ d a = (t d b - b d t)/(t^2) = 0 $
因为 $b,t$ 都来自 $B$, 所以 $d b = d t = 0$. 这某种意义上是直观的, 若 $A=B_f$, 那么 $Spec A$ 是 $Spec B$ 的开子集, 也就是局部化不会引入新的微分.

== 微分正合列 (仿射情形)

#theorem(title:[余切正合列, 仿射情形])[
  设 $C->B->A$ 是环同态, 那么存在自然的 $A$-模正合列
  $ A times.o_B Omega_(B\/C) stretch(->,size:#100%)^(a times.o d b|->a d b) Omega_(A\/C) stretch(->,size:#100%)^(d a|->d a) Omega_(A\/B) --> 0 $
  其中的 $d$ 随着环同态的变化而变化.
]

#proof[
  $Omega_(A\/C)->Omega_(A\/B)$ 的满射性显然. 因为这个映射由
  $ d a |-> d a $
  给出, 其中 $a in A$. 中间项的复合显然是
  $ a times.o d_(B\/C) b |-> a d_(A\/C) b |-> a d_(A\/B) b = 0 $
  只需把 $Omega_(A\/B)$ 识别为 $A times.o_B Omega_(B\/C) -> Omega_(A\/C)$ 的余核. 现在 $Omega_(A\/B)$ 与 $Omega_(A\/C)$ 完全相同, 只是加入了额外的关系
  $ d b = 0, quad b in B $
  这些恰好就是左边的元素 $1 times.o d b$ 的像.
]

上面的定理就是说, 将 $X\/Z$ 的总微分中来自 $Y\/Z$ 的部分去掉, 就得到 $X\/Y$ 的总微分. 这在几何上是显然的.

#theorem(title:[余法正合列, 仿射情形])[
  设 $B$ 是一个 $C$-代数, $I subset B$ 是一个理想, 并且 $A=B\/I$. 那么存在自然的 $A$-模正合列
  $ I\/I^2 stretch(->,size:#100%)^(delta:i|->1 times.o d i) A times.o_B Omega_(B\/C) stretch(->,size:#100%)^(a times.o d b|->a d b) Omega_(A\/C) --> 0 $
  其中 $d$ 随着环同态的变化而变化.
]

#proof[
  我们将说明
  $ delta:I\/I^2 -> A times.o_B Omega_(B\/C) $
  的余核是 $Omega_(A\/C)$. 考虑 $A times.o_B Omega_(B\/C)$ 作为 $A$-模. 由符号 $d b$ 生成, 其中 $b in B$ 并且满足关系:

  1. 对于 $C->B$ 像中的 $c$, $d c = 0$.
  2. 加性, 以及Leibniz律.

  另一方面 $Omega_(A\/C)$ 也由类似的方法定义. 只不过在 $A$ 中有更多关系, 这些关系正是 $I subset B$ 的元素. 也就是说, $A=B\/I$, 所以每个 $i in I$ 在 $A$ 中都变成了 $0$. 因此在 $Omega_(A\/C)$ 中, 我们有
  $ d i = 0, quad i in I $
  于是我们可以这样得到 $Omega_(A\/C)$: 先取 $A times.o_B Omega_(B\/C)$, 然后对所有的 $i in I$ 强制 $d i = 0$. 但这些额外的关系正好是 $delta$ 的像, 因为 $delta(i)=1 times.o d i$. 所以
  $ Omega_(A\/C) tilde.eq "coker" (I\/I^2 -->^delta A times.o_B Omega_(B\/C)) $
]

这个正合列应该理解成小空间的微分, 就是大空间的微分模去定义小空间的方程给出的一阶关系.

设 $X subset Y$ 是闭嵌入, 仿射地说, 就是 $Y=Spec B$, $X=Spec A$, 其中 $A=B\/I$. 我们称层
$ tilde(I\/I^2) $
为 $X$ 在 $Y$ 中的余法模.

#definition(title:[余法层 & 法层])[
  设 $i:X arrow.hook Y$ 是概形的闭嵌入, 由理想层 $cal(I)$ 切出, 定义这个闭嵌入的 *余法层* (conormal sheaf) 为
  $ cal(I)\/cal(I)^2 $
  记作 $cal(N)^or_(X\/Y)$. 定义 *法层* (normal sheaf) 为
  $ cal(N)_(X\/Y)  = (cal(N)^or_(X\/Y))^or $
]

#theorem[
  设 $D subset X$ 是一个有效Cartier除子, 则其余法层 $cal(N)^or_(D\/X)$ 是 $cal(O)(-D)|_D$, 从而法层是 $cal(N)_(D\/X) = cal(O)(D)|_D$.
]

== Kähler微分层

#definition(title:[Kähler微分层])[
  设 $X->Y$ 是概形的态射, 定义 *Kähler微分层* (Kähler differential sheaf) 为
  $ Omega_(X\/Y) = cal(I)_Delta\/cal(I)^2_Delta $
  其中 $Delta:X->X times_Y X$ 是对角闭嵌入.
]

例如, 仿射空间 $AA^1_k$ 上, 我们来确定 $Omega_(AA^1_k\/k)$. 由定义, 设
$ X = AA^1_k = Spec k[x], quad Y = Spec k $
则
$ X times_Y X = Spec(k[x] times.o_k k[x]) = Spec k[x_1,x_2] $
对角闭嵌入
$ Delta : k[x_1,x_2] -> k[x] $
由 $x_1|->x$, $x_2|->x$ 给出. 于是
$ I = ker(k[x_1,x_2]->k[x]) = (x_1-x_2) $
是主理想, 设 $x_1-x_2 = epsilon$, 有
$ I\/I^2 = (epsilon)\/(epsilon^2) tilde.eq k[x_1,x_2]\/(x_1-x_2) dot epsilon tilde.eq k[x] dot epsilon $
这是一个自由秩 $1$ 模. 令 $d x = epsilon mod epsilon^2$, 那么
$ Omega_(X\/k) tilde.eq k[x] dot d x $

为什么这个定义是合理的? 考虑一般的仿射情形. 设
$ X = Spec A, quad Y = Spec B $
则
$ X times_Y X = Spec(A times.o_B A) $
对角理想
$ I = ker(A times.o_B A -> A) $
在 $A times.o_B A$ 中考虑 $a times.o 1 - 1 times.o a$, 它生成了 $I$. 并且我们容易验证
$ I\/I^2 tilde.eq Omega_(A\/B) $
映射是 $a times.o 1 - 1 times.o a |-> d a$.

至于仿射局部的相容性, 我们只需检查其与局部化的相容性. 这是容易验证的, 本质就是下面的结论喵:

1. 局部化总是满足 $A_f times.o_B A_f tilde.eq (A times.o_B A)_f$.
2. 取核和局部化交换.
3. 局部化平坦, 从而保持正合列 (商), 从而 $I\/I^2 times.o A_f tilde.eq I_f\/I_f^2$.

显然微分层是拟凝聚层, 因为我们在局部用微分模确定了它.

== 结论的全局推广

#theorem(title:[余切正合列])[
  设 $X-->^pi Y-->^rho Z$ 是概形的态射, 存在 $X$ 上拟凝聚层的正合列
  $ pi^* Omega_(Y\/Z) --> Omega_(X\/Z) --> Omega_(X\/Y) --> 0 $
] <cotangent-seq>

#theorem(title:[余法正合列])[
  设 $rho:Y->Z$ 是概形态射, $i:X arrow.hook Y$ 是闭嵌入, 则有 $X$ 上拟凝聚层的正合列
  $ cal(N)^or_(X\/Y) -->^Delta i^* Omega_(Y\/Z) --> Omega_(X\/Z) --> 0 $
] <conormal-seq>

#theorem[
  若
  #align(center, diagram({
	node((0, 0), [$X'$])
	node((1, 0), [$X$])
	node((0, 1), [$Y'$])
	node((1, 1), [$Y$])
	edge((0, 0), (1, 0), [$mu$], label-side: left, "->")
	edge((0, 0), (0, 1), "->")
	edge((1, 0), (1, 1), "->")
	edge((0, 1), (1, 1), "->")
  }))
  是概形的交换图, 那么存在 $X'$ 上拟凝聚层的自然同态
  $ mu^* Omega_(X\/Y) --> Omega_(X'\/Y') $
  若该交换图是纤维积, 则该同态是同构.
]

也就是说, Kähler微分层在基变换下相容.

== 光滑概形的定义

我们可以给出光滑性的定义

#definition(title:[光滑概形])[
  一个 $k$-概形 $X$ 被称为*相对维数 $n$ 光滑的* (smooth), 若:

  1. $X$ 是局部有限型的.
  2. $X$ 是纯维数 $n$ 的.
  3. $Omega_(X\/k)$ 是一个秩为 $n$ 的局部自由层.
]

等价地, 这意味着 $X$ 可以被仿射开集覆盖, 使得每个开集形如
$ Spec k[x_1,...,x_(n+r)]\/(f_1,...,f_r) $
并且Jacobi行列式
$ det ( (partial f_j) / (partial x_i) ) $
在开集上非零, 也就是说这个矩阵可逆. 这两个定义是等价的, 因为 $Omega_(X\/k)$ 就是Jacobi矩阵的余核.

#theorem[
  设 $i:X arrow.hook Y$ 是域 $k$ 上光滑簇之间的闭嵌入, 其余法层为 $cal(N)^or_(X\/Y)$, 那么 $cal(N)^or_(X\/Y)$ 是一个局部自由层, 并且余法正合列左边正合
  $ 0 --> cal(N)^or_(X\/Y) -->^Delta i^* Omega_(Y\/k) --> Omega_(X\/k) --> 0 $  
]

#proof[
  因为结论与代数闭包基变换相容, 大可假设 $k = overline(k)$ 喵, 此时光滑簇的闭点都是正则点. 设 $x in X$ 是闭点, 因为 $X,Y$ 光滑, 所以局部环 $cal(O)_(X,x)$ 和 $cal(O)_(Y,x)$ 都是正则局部环, 闭嵌入对应满射
  $ cal(O)_(Y,x) ->> cal(O)_(X,x) $
  在正则局部环上, 正则闭子概形的理想可以一组正则序列 $f_1,...,f_r$ 生成, 其中 $r = "codim"_Y X$. 于是由正合序列的基本性质, $cal(I)_x\/cal(I)^2_x$ 是 $cal(O)_(X,x)$-自由模, 基为
  $ overline(f)_1,...,overline(f)_r $
  从而 $cal(I)\/cal(I)^2$ 局部自由秩 $r$.

  下面证明 $Delta$ 单, 依旧局部化到一点 $x in X$, 取上面的正则序列表示, 余法正合列在茎上为
  $ cal(I)_x\/cal(I)^2_x -->^(Delta_x) Omega_(cal(O)_(Y,x)\/k) times.o_(cal(O)_(Y,x)) cal(O)_(X,x) --> Omega_(cal(O)_(X,x)\/k) --> 0 $
  由于 $X,Y$ 光滑, $Omega_(Y\/k)$ 和 $Omega_(X\/k)$ 局部自由, 且
  $ "rank" Omega_(Y\/k) = dim Y, quad "rank" Omega_(X\/k) = dim X $
  同时
  $ "rank" (cal(I)\/cal(I)^2) = "codim"_Y X = dim Y - dim X $
  因此在泛点处取纤维, 得到有限维线性空间的右正合列
  $ (cal(I)\/cal(I)^2)|_eta --> (i^*Omega_(Y\/k))|_eta --> (Omega_(X\/k))|_eta --> 0 $
  右边两项维数分别为 $dim Y, dim X$, 所以中间映射的核维数为
  $ dim Y - dim X = "codim"_Y X $
  而右边线性空间的维数也一样, 因此左边映射在泛点处是单射, 于是 $Delta$ 是单射, 从而余法正合列左边正合.
]

#corollary[
  法正合列
  $ 0 --> cal(T)_(X\/k) --> cal(T)_(Y\/k)|_X --> cal(N)_(X\/Y) --> 0 $
]

#corollary[
  设 $Y$ 是一个光滑 $k$-簇, 并且 $q in Y$ 是一个闭点, 其剩余域 $kappa(q)$ 是 $k$ 的可分扩张. 闭嵌入的余法层给出余切空间和纤维的同构
  $ frak(m)_q\/frak(m)^2_q tilde.eq Omega_(Y\/k) times.o_(cal(O)_Y) kappa(q) $
]

== 几何亏格 (曲线)

#definition(title:[几何亏格])[
  一条正则, 不可约的域 $k$ 上的射影曲线 $C$ 的*几何亏格* (geometric genus) 定义为
  $ p_g (C) := h^0 (C,Omega_(C\/k)) $
]

我们可以证明这个条件下 $Omega_(C\/k)$ 是凝聚层, 从而这个数必然有限. 由Serre对偶, 我们可以证明他和算术亏格
$ p_a(C) := h^1(C,cal(O)_C) $
相同. 我们后面会给出高维的推广和这个结论的解释.

例如 $PP^1_k$, 带有通常的射影坐标 $x_0,x_1$. 他有两个仿射片
$ Spec k[x_(1\/0)], quad Spec k[x_(0\/1)] $
都同构于 $AA^1_k$, 微分层都是平凡的 $Omega_(AA^1_k\/k) tilde.eq cal(O)_(AA^1_k)$. 于是 $Omega_(PP^1_k\/k)$ 是一个线丛, 由于其上的线丛都形如 $cal(O)(m)$, 我们只需要确定他是哪个 $cal(O)(m)$.

取第一个仿射片上的截面 $d x_(1\/0)$, 它在这个仿射片上没有零点也没有极点, 但在另一片上
$ d x_(1\/0) = d (frac(1,x_(0\/1))) = - frac(1,x^2_(0\/1)) d x_(0\/1) $
因此这个截面在 $x_(0\/1)=0$ 时有二阶极点, 也就是说 $Omega_(PP^1_k\/k) tilde.eq cal(O)(-2)$, 从而
$ p_g (PP^1_k) = h^0(PP^1_k,cal(O)(-2)) = 0 $

== Euler正合列

我们来考虑射影空间的微分, 因为射影空间 $PP^n_A$ 被形如 $AA^n_A$ 的仿射片覆盖, 在这些仿射开集上, 微分层是秩 $n$ 的局部自由层, 所以 $Omega_(PP^n_A \/ A)$ 也是秩 $n$ 的局部自由层.

#theorem(title:[Euler正合列])[
  微分层 $Omega_(PP^n_A \/ A)$ 满足如下的如下的正合列
  $ 0 --> Omega_(PP^n_A \/ A) -->^alpha cal(O)_(PP^n_A)(-1)^(plus.o n+1) -->^phi cal(O)_(PP^n_A) --> 0 $
]

#remark[
  其中右边的态射
  $ phi : (s_0,...,s_n) |-> x_0 s_0 + ... + x_n s_n $
  其中 $s_i$ 是 $cal(O)_(PP^n_A)(-1)$ 的局部截面, 而 $x_i s_i$ 是$cal(O)_(PP^n_A)$ 的全局截面, 也就是 $phi$ 是由 $x_0,...,x_n$ 给出的.
  
  至于左边的态射, 在标准开集 $U_j=D_+ (x_j)$ 上, $t_i = x_i\/x_j$. Euler序列的嵌入 $alpha$ 局部由
  $ d t_i |-> e_i - t_i e_j $
  给定.
]

#corollary[
  有正合列
  $ 0 --> cal(O)_(PP^n_A) -->^(phi^or) cal(O)_(PP^n_A)(1)^(plus.o n+1) --> cal(T)_(PP^n_A \/ A) --> 0 $
]

== 可分与泛可分态射

下设 $X,Y$ 皆为整概形.

#definition(title:[可分态射])[
  若 $f:X->Y$ 是:

  1. 有限态射.
  2. 支配态射.
  3. 诱导函数域扩张 $K(Y)\/K(X)$ 是可分扩张.

  则称之为*可分态射* (separable morphism).
]

#definition(title:[泛可分态射])[
  若 $f:X->Y$ 是:

  1. 支配态射.
  2. 诱导函数域扩张 $K(Y)\/K(X)$ 是有限可分扩张.

  则称之为*泛可分态射* (generically separable morphism).
]

这两个定义的区别在于, 泛可分态射不要求 $f$ 在所有地方有限, 只要求泛点附近像有有限覆盖. 泛可分可以理解为"几何泛纤维是有限个约化点". 这里几何泛纤维是指基变换到代数闭包

#theorem[
  设 $pi:X->Y$ 是相同维数 $n$ 的整簇之间的泛可分态射, 并且 $Y$ 光滑, 那么余切正合列左边正合
  $ 0 --> pi^* Omega_(Y\/k) -->^phi Omega_(X\/k) --> Omega_(X\/Y) --> 0 $
]

== 分歧

=== 分歧的概念

我们先来看一个引例, 我们考虑最简单的映射 $f : AA^1_x -> AA^1_t$, 由
$ k[t] -> k[x], quad t |-> x^2 $
给出. 取一个点 $a in AA^1_t$, 得纤维
#align(center, diagram({
	node((0, 2), [$AA^1_t$])
	node((0, 1), [$AA^1_x$])
	node((-1, 2), [$"Spec" k$])
	node((-1, 1), [$f^(-1)(a)$])
	edge((-1, 2), (0, 2), [$a$], label-side: right, "->")
	edge((0, 1), (0, 2), [$f$], label-side: left, "->")
	edge((-1, 1), (0, 1), "->")
	edge((-1, 1), (-1, 2), "->")
}))
其中 $f^(-1)(a) = Spec(k[x]times.o_(k[t])k) tilde.eq Spec k[x] \/ (x^2-a)$. 下设 $k=overline(k)$ 且 $"char" k!=2$, 则
$ x^2-a = (x-sqrt(a))(x+sqrt(a)) $
纤维是两个点
$ f^(-1)(a) = {+sqrt(a),-sqrt(a)} $
因此附近看上去像是一种 $2:1$ 的覆盖. 然而当 $a=0$ 时, 我们有
$ Spec k[x]\/(x^2) $
是一个非约化的胖点, 也就是说两个点合成了一个带有无穷小结构的点, 这就是异常. 这个点在微分意义下特殊:

例如, 我们看一种非分歧的情况, 考虑 $g:AA^1_x -> AA^1_t$ 由 $t|->x$ 给出, 那么微分 $d t=d x$, 意思是 $x$ 方向上的任何一个无穷小变化, 会直接对应到 $t$ 方向上的无穷小变化, 没有任何信息丢失. 然而在 $f$ 的情况有 $d t = d (x^2)$, 从而 $d t = 2 x d x$. 这个微分在 $x!=0$ 时, $2 x$ 是可逆元, 于是 $d t=0$ 当且仅当 $d x=0$, 也就是说 $x$ 方向上的无穷小变化, 可以完全对应到 $t$ 方向上的无穷小变化. 然而在 $x=0$ 时, 我们有 $d t = 0$, 无论 $d x$ 是什么, 都会被映射到 $0$. 也就是说, 在这个点上, 我们丢失了信息. 这就是分歧的微分意义.

=== 分歧的定义

我们发现, 对于 $x|->x^2$ 的例子, 唯一"坏掉"的点 $x=0$ 满足
$ (Omega_f)_x != 0 $
在 $k[x]$ 中, $t=x^2$, 由于 $t$ 属于底层 $k[t]$, 相对微分里 $d t=0$. 而
$ d t = d(x^2) = 2 x d x $
于是
$ Omega_f = frac(k[x] d x ,(2 x d x)) tilde.eq (k[x]\/(x)) d x tilde.eq k d x $
作为 $k[x]$-模. 容易验证, 在 $frak(p)=(x-a)$ 处局部化, 那么
$ (Omega_f)_frak(p) = ((k[x]\/(x))d x)_frak(p) $
局部化和商交换, 从而
$ (Omega_f)_frak(p) tilde.eq (k[x]\/(x))_frak(p) d x $
而在 $k[x]_frak(p)$ 中, 因为 $frak(p)=(x-a)$ 且 $a!=0$, 那么 $x$ 变成单位, 但在 $k[x]\/(x)$ 中有 $x=0$, 于是 $1=x^(-1)x=0$, 整个环退化为 $0$. 而当 $x=0$ 时, $x$ 不是单位, 所以 $(k[x]\/(x))_frak(p) != 0$. 于是我们有了分歧的定义:

#definition(title:[分歧点])[
  设 $f:X->Y$ 是一个有限型态射, 若
  $ (Omega_f)_x != 0 $
  对于点 $x in X$ 成立, 则称 $x$ 是 $f$ 的一个*分歧点* (ramification point).
]

#lemma[
  设 $f:X->Y$ 是局部有限型的态射, 那么 $Omega_f$ 是有限型的拟凝聚层.
]

#proof[
  取任意仿射开集
  $ V = Spec A subset Y, quad U = Spec B subset f^(-1)(V) $
  因为 $f$ 局部有限型, 从而 $B$ 是有限生成的 $A$-代数, 于是可作
  $ B tilde.eq A[x_1,...,x_n]\/I $
  由相对微分的正合列
  $ I\/I^2 --> plus.o.big_(i=1)^n B d x_i --> Omega_f --> 0 $
  因此 $Omega$ 由有限个元素
  $ d x_1,...,d x_n $
  生成, 从而是有限生成的 $B$-模.
]

我们知道, 有限型拟凝聚层的支撑是闭集, 因此对应有限型的态射, 其分歧点的集合是闭集. 并且可以赋予闭子概形结构, 最直接的就是
$ "Ram"(f) = V("Ann"_(cal(O)_X) Omega_f) $
不过我们有个更直观的方法:

下设 $X,Y$ 皆为整概形.

#definition(title:[可分态射])[
  若 $f:X->Y$ 是:

  1. 有限态射.
  2. 支配态射.
  3. 诱导函数域扩张 $K(Y)\/K(X)$ 是可分扩张.

  则称之为*可分态射* (separable morphism).
]

#definition(title:[泛可分态射])[
  若 $f:X->Y$ 是:

  1. 支配态射.
  2. 诱导函数域扩张 $K(Y)\/K(X)$ 是有限可分扩张.

  则称之为*泛可分态射* (generically separable morphism).
]

这两个定义的区别在于, 泛可分态射不要求 $f$ 在所有地方有限, 只要求泛点附近像有有限覆盖. 泛可分可以理解为"几何泛纤维是有限个约化点". 这里几何泛纤维是指基变换到代数闭包

#theorem[
  一个点 $p in X$ 是泛可分态射 $pi:X->Y$ 的分歧点, 当且仅当Jacobi行列式 $det J_pi (p)=0$. 
]

#remark[我们知道这不依赖局部坐标选取, 因为Jacobi行列式在不同坐标下只相差可逆函数.]


#proof[
  设 $X,Y$ 和 $pi$ 都符合要求, 于是
  $ Omega_(X\/k), quad Omega_(Y\/k) $
  都是秩 $n$ 的局部自由层. By def, $p$ 分歧当且仅当
  $ phi(p) : pi^* Omega_(Y\/k) times.o kappa(p) --> Omega_(X\/k) times.o kappa(p) $
  两边都是 $kappa(p)$-线性空间, 利用线性空间结论即得.
]

== Riemann--Hurwitz

我们先不更高维的情况如分歧概形, 分歧除子的表现. 我们先来看曲线的情况. 设 $X,Y$ 都是维数 $1$ 的概形, 那么分歧轨迹 (定义为分歧点的集合) 和分支轨迹 (定义为分歧点的像) 都是有限集, 

Riemann--Hurwitz的核心思想是: 曲线态射的分歧, 可以通过微分 $d x$ 的消失阶数来刻画. 设 $X,Y$ 都是光滑曲线, $p in X$, $q = pi(p) in Y$, 那么它们在这两个点的局部环都是DVR. 取局部参数
$ s in cal(O)_(X,p), quad t in cal(O)_(Y,q) $
$s$ 是 $p$ 附近的局部参数, $t$ 是 $q$ 附近的局部参数. 在 $cal(O)_(X,p)$ 中可以写成
$ pi^*t = u s^(e_p), quad u in cal(O)^times_(X,p) $
其中 $e_p = v_p (pi^*t)$. 就是通常意义下的分歧指数. 对其微分
$ pi^*(d t) = d(u s^(e_p)) = e_p u s^(e_p - 1) d s + s^(e_p) d u $
由于 $(Omega_(X\/k))_p$ 由 $d s$ 生成, 可以写成
$ pi^*(d t) = a_p d s $
于是微分映射
$ d pi : pi^* Omega_(Y\/k) --> Omega_(X\/k) $
在局部就是乘以 $a_p$. 更进一步, 定义
$ d_p = "ord"_p (a_p) = "ord"_p (pi^* d t) $
那么 $d_p$ 就是分歧除子在 $p$ 处的系数.
$ R_pi = sum_(p in X) d_p [p] $
并且局部相对微分模为
$ (Omega_f)_p tilde.eq cal(O)_(X,p) d s \/ a_p cal(O)_(X,p) d s $
于是
$ ell_(cal(O)_(X,p)) (Omega_f)_p = d_p $
这里, $a_p$ 可以理解为映射在这个局部坐标处的导数, 而 $d_p$ 就是这个导数在点 $p$ 的消失阶数. $a_p$ 依赖于局部参数的选取, 但是 $d_p$ 不依赖于局部参数的选取.

例如, 对于 $pi:AA^1_k->AA^1_k, t|->s^3$. 将源上坐标记为 $s$, 目标上坐标记为 $t$, 那么考虑点
$ p = (s=0), quad q = pi(p) = (t=0) $
局部上有
$ pi^*t = s^3 $
于是
$ pi^*(d t) = d(s^3) = 3 s^2 d s $
因此这里 $a_p = 3 s^2$. 若 $"char" k!=3$, 则 $3$ 是单位, 从而
$ d_p = "ord"_p (3 s^2) = 2 $

#definition(title:[分歧指数])[
  设 $pi:X->Y$ 是光滑曲线之间的有限可分态射, $p in X$ 且 $q = pi(p)$, 取DVR的局部参数
  $ s in cal(O)_(X,p), quad t in cal(O)_(Y,q) $
  在 $cal(O)_(X,p)$ 中可以写成
  $ pi^*t = u s^(e_p), quad u in cal(O)^times_(X,p) $
  这里 $e_p:="ord"_p (pi^* t)$ 称作 $p$ 处的*分歧指数* (ramification index). 若剩余域特征为 $"char" kappa(p) = c$, 则定义:

  - $p$ 处*驯分歧* (tame ramification), 若 $c divides.not e_p$.
  - $p$ 处*野分歧* (wild ramification), 若 $c divides e_p$.
]

在驯分歧的时候, 我们总有 $d_p + 1 = e_p$ (我们经常也把这个作为分歧指数的定义), 而在野分歧的时候, 我们有 $d_p + 1 > e_p$.

#remark[
  分歧指数 $e_p$ 的意义是: 底空间的一个零点拉回后的重数. 因为
  $ pi^*t = u s^(e_p) $
  所以 $Y$ 上的函数 $t$ 在 $q$ 有一个一阶零点, 而拉回到 $X$ 上后, 在 $p$ 处有一个 $e_p$ 阶零点.
  $ "ord"_p (pi^* t) = e_p $
  除子语言中
  $ pi^*[q] = sum_(p|->q)e_p [p] $
]

所谓驯分歧的含义就是, 微分只发生了"应有"的消失. 若 $c divides.not e_p$, 那么 $e_p$ 在局部环中就是可逆的, 因此
$ e_p u s^(e_p - 1) d s $
确实是最低阶项, 不会因特征消失, 于是
$ "ord"_p (d t) = e_p - 1 $
也就是说驯分歧中微分退化的程度可以完全由 $e_p$ 个分支合并解释, 没有额外的特征 $p$ 现象发生. 而野分歧就是另一副景象: 若 $c divides e_p$, 那在特征 $c$ 中
$ "ord"_p (d t) = e_p - 1 $
完全消失, 只剩下 $d t=s^(e_p)d u$. 从而
$ "ord"_p (d t) >= e_p > e_p - 1 $
其本质就是除了 $e_p$ 重合本身以外, 正特征又额外杀掉了导数的最低阶数项, 使得切映射的退化比预期还要严重.

#definition(title:[分歧除子])[
  设 $pi:X->Y$ 是光滑曲线之间的有限可分态射, 定义 *分歧除子* (ramification divisor) 为
  $ R_pi = sum_(p in X) d_p [p] $
  其中 $d_p = ell_(cal(O)_(X,p)) (Omega_pi)_p$.
]

#theorem(title:[Riemann--Hurwitz公式])[
  设 $pi:X->Y$ 是 $k$-射影正则曲线之间的有限可分态射, 且态射的次数为 $n:=[K(X):K(Y)]$. 令 $R$ 为 $pi$ 的分歧除子, 则有
  $ 2 g(X) - 2 = n (2 g(Y) - 2) + deg R $
]

#proof[
  由余切正合列
  $ 0 --> pi^* Omega_(Y\/k) --> Omega_(X\/k) --> Omega_pi --> 0 $
  由于次数对正合列可加
  $ deg Omega_X = deg (pi^* Omega_Y) + deg Omega_pi $
  由Serre对偶, 第一项为 $2 g(X)-2$, 第二项为 $n(2 g(Y)-2)$, 第三项为 $deg R$.
]
