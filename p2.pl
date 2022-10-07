/*
    Name(s): Joshua Authement and Calin Farmer
    Date: 5/15/2022
    Course Number and Section: 330 001
    Quarter: Spring 2022
    Project #: 2
*/



/* Implementing trees using Prolog terms*/
tree(leaf).
node(int,tree,tree).

myTree(T) :- T = node(8,node(5,node(2,tree,tree),node(6,tree,tree)),node(11,tree,node(12,tree,tree))).

/* Argument is a BST. Succeeds if the tree is empty and fails otherwise.
Calin fixed this function as I had originally typed it incorrectly. */
isEmpty(tree).
isEmpty(node(_,tree,tree)) :- false.

/* First argument is a BST and the second argument is a file name. Visits the tree 
nodes in preorder recursively and writes its data to the file separated by spaces.
The phrase() was added from googling a solution described below.  */
preOrderWrite(T,Filename) :- tell(Filename),phrase(preorder(T),R), sep(R,E), write(E), told.

/* Helper function to get rid of the brackets and commas, writing only the numbers
followed by spaces.
Calin came up with this helper function which is repeated throughout the code. */
sep([],"").
sep([H|T],R) :- write(H), write(" "), sep(T,R).

/* Orders the tree via preorder traversal. At first my code was only giving part of
the tree and by googling I found that using DCGs  would solve the issue.
Site: https://www.metalevel.at/prolog/dcg.  */
preorder(tree) --> [].
preorder(node(X,L,R)) --> [X],preorder(L),preorder(R).

/* First argument is a BST and the second argument is a file name. Visits the tree 
nodes in inorder recursively and writes its data to the file separated by spaces. */
inOrderWrite(T,Filename) :- tell(Filename),phrase(inorder(T),R), sep2(R,E),write(E),told.

/* Helper function to get rid of the brackets and commas, writing only the numbers
followed by spaces */
sep2([],"").
sep2([H|T],R) :- write(H), write(" "), sep2(T,R).

/* Orders the tree via inorder traversal */
inorder(tree) --> [].
inorder(node(X,L,R)) --> inorder(L),[X],inorder(R).

/* First argument is a BST and the second argument is a file name. Visits the 
tree nodes in postorder recursively and writes its data to the file separated by 
spaces. */
postOrderWrite(T,Filename) :- tell(Filename), phrase(postorder(T),R), sep3(R,E),write(E),told.

/* Helper function to get rid of the brackets and commas, writing only the numbers
followed by spaces */
sep3([],"").
sep3([H|T],R) :- write(H), write(" "), sep3(T,R).

/* Orders the tree via postorder traversal */
postorder(tree) --> [].
postorder(node(X,L,R)) --> postorder(L),postorder(R),[X].

/* First argument is a BST. The second argument is matched with the smallest value 
in the tree. If the tree is empty, the second argument is matched with -1 OR the 
predicate may fail. */
getMin(node(X,tree,_),X).
getMin(node(X,L,_),R) :- X \= tree, getMin(L,R).

/* First argument is a BST. The second argument is matched with the largest value 
in the tree. If the tree is empty, the second argument is matched with -1 OR the
 predicate may fail. */
getMax(node(X,_,tree),X).
getMax(node(X,_,R),F) :- X\= tree, getMax(R,F).

/* First argument is a BST and the second argument is an integer x. The third 
argument is matched with a new tree containing data value x inserted correctly. 
If x is a value already in the tree, then the third argument is matched with the 
tree unchanged. 
*/
insert(tree,Y,node(Y,tree,tree)).
insert(node(X,L,R),Y, node(X,L,R)) :- X =:= Y.
insert(node(X,L,R),Y, node(X,L2,R)) :- Y<X, insert(L,Y,L2).
insert(node(X,L,R),Y, node(X,L,R2)) :- Y>X, insert(R,Y,R2).

/* Helper function for the delete predicate that balances the tree.
Calin did this portion*/
balance(node(X,L,R),node(X,L,M)) :- getMin(node(X,L,R),M), M>X.
balance(node(X,L,R),node(M,L,R)) :- getMin(node(X,L,R),M),M=X.
balance(node(X,L,R),node(X,M,R)) :- getMin(node(X,L,R),M), M<X.

/* First argument is a BST and the second argument is an integer x. Uses 
recursion to delete the tree node containing data value x, if it exists, and 
adjusts nodes so that the tree remains a BST, which is then matched with the third 
argument. If the tree does not contain x, the third argument is matched with the 
tree unchanged. Uses the predicate getMin. 
Calin did this portion*/
delete(tree,_,tree).
delete(node(X,L,R),A,Y) :- A =:= X, balance(node(X,L,R),Y). 
delete(node(X,L,R),A,node(X,L,R)) :- A \= X, A \= L, A \= R.
delete(node(X,L,R),A,Y) :- A \= X, A<X, delete(L,A,L2), balance(node(X,L2,R),Y).
delete(node(X,L,R),A,Y) :- A \= X, A>X, delete(R,A,R2), balance(node(X,L,R2),Y).

/* First argument is a file name. The second argument is matched with a BST 
constructed from the integers contained in the file, which are separated by 
spaces and read recursively. Uses the insert predicate.
Calin created these two portions, I just made minor tweaks to make them work. */
treeRead(Filename,T) :- see(Filename), get0(X), S = tree, hel(X,S,T),seen.

/* Helper function that uses get0 to read the characters and then insert
them into a tree. */
hel(-1,S,S).
hel(X,S,R) :- X =:= 32, get0(X2),hel(X2,S,R).
hel(X,S,R) :- X \= 32,X1 is X-48, insert(S,X1,W), get0(X2), hel(X2,W,R).

