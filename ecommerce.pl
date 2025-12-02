:- module(ecommerce, [recommend/2]).

/* ============================================
   FACTS (Example Data)
   ============================================ */

% browsing(User, Category).
browsing(john, gaming).
browsing(john, gaming).   % repeated browsing

% purchased(User, Product).
purchased(john, laptop).

% category(Product, Category).
category(laptop, electronics).
category(gaming_mouse, gaming).
category(gaming_headset, gaming).
category(keyboard_pro, electronics).
category(gaming_laptop, gaming).
category(high_end_gpu, gaming).

% wishlist(User, Category).
wishlist(john, gaming).

% rated(User, Category).
high_rating(john, gaming).

% views(User, Product, Count).
views(john, gaming_laptop, 3).

% cart(User, Product).
cart(john, laptop).

% bought_together(ProductX, ProductY).
bought_together(laptop, gaming_mouse).
bought_together(laptop, gaming_headset).

% category_strength(User, Category, Level).
category_strength(john, gaming, strong).


/* ============================================
   PRODUCTION RULES — EXACTLY YOUR 8 RULES
   ============================================ */

% RULE 1:
% IF a customer frequently browses category X
% THEN recommend products from category X.
recommend(User, Product) :-
    browsing(User, Category),
    category(Product, Category).

% RULE 2:
% IF a customer purchased an item in category X
% THEN recommend complementary items from category X.
recommend(User, Product) :-
    purchased(User, Item),
    category(Item, Category),
    category(Product, Category),
    Product \= Item.

% RULE 3:
% IF a customer adds products to wishlist/saved
% THEN recommend top-rated items from same category.
recommend(User, Product) :-
    wishlist(User, Category),
    category(Product, Category).

% RULE 4:
% IF a customer gives high ratings to category X
% THEN recommend similar items in category X.
recommend(User, Product) :-
    high_rating(User, Category),
    category(Product, Category).

% RULE 5:
% IF a user views an item multiple times
% THEN recommend related alternatives.
recommend(User, Product) :-
    views(User, ViewedItem, Count),
    Count >= 2,
    category(ViewedItem, Category),
    category(Product, Category),
    Product \= ViewedItem.

% RULE 6:
% IF cart contains an item but not purchased
% THEN recommend upgraded versions.
recommend(User, Product) :-
    cart(User, Item),
    category(Item, Category),
    category(Product, Category),
    Product \= Item.

% RULE 7:
% IF X and Y are bought together AND the customer bought X
% THEN recommend Y.
recommend(User, ProductY) :-
    purchased(User, ProductX),
    bought_together(ProductX, ProductY).

% RULE 8:
% IF strong preference for category X
% THEN recommend trending/new items from X.
recommend(User, Product) :-
    category_strength(User, Category, strong),
    category(Product, Category).
