(*
    Name(s): Joshua Authement and Calin Farmer
    Date: 4/22/2022
    Course Number and Section: 330 01
    Quarter: Spring 2022
    Project #: 1
*)

datatype tree = leaf | node of int * tree * tree;

(* Returns true if the tree is empty and false otherwise *)
fun isEmpty leaf = true
	| isEmpty _ = false;

(* Helper function that converts each element in the list to a string *)
fun help [] = nil
	| help(x::xs) = Int.toString(x)::" "::help(xs);

(* Helper function that visits the nodes in preorder recursively. 
Code came from: https://www.cse.iitd.ac.in/~saroj/LFP/LFP_2013/sml4.pdf 
*)
fun preorder leaf = nil
	| preorder(node(root,left,right)) = [root] @ preorder(left) @ preorder(right);

(* Inputs a tree and string representing a file name. By using the helper functions
the tree nodes are visited in preorder recursively and writes its data to the file 
separated by spaces. *)
fun preOrderWrite (t, st) =
	let
		val s = TextIO.openOut(st)
		val pt = preorder(t)
		val c = concat(help(pt))
	in
		if isEmpty(t) then TextIO.closeOut(s) else TextIO.output(s,c);
		TextIO.closeOut(s)
	end;

(* Helper function that vists the nodes in inorder recursively. 
Used the preorder code from above as a base and switched around the ordering of the
root,left,and right for inorder*)
fun inorder leaf = nil
	| inorder(node(root,left,right)) = inorder(left) @ [root] @ inorder(right);

(* Inputs a tree and string representing a file name. By using the helper functions
the tree nodes are visited in inorder recursively and writes its data to the file 
separated by spaces. 
calin work on this portion*)
fun inOrderWrite(t, st) =
	let
		val s = TextIO.openOut(st)
		val pt = inorder(t)
		val c = concat(help(pt))
	in
		if isEmpty(t) then TextIO.closeOut(s) else TextIO.output(s,c);
		TextIO.closeOut(s)
	end;

(* Helper function that vists the nodes in postorder recursively. 
Used the preorder code from above as a base and switched around the ordering of the
root,left,and right for postorder*)
fun postorder leaf = nil
	| postorder(node(root,left,right)) = postorder(left) @ postorder(right) @ [root];

(* Inputs a tree and string representing a file name. By using the helper functions
the tree nodes are visited in postorder recursively and writes its data to the file 
separated by spaces. 
Calin worked on this portion*)
fun postOrderWrite(t, st) =
	let
		val s = TextIO.openOut(st)
		val pt = postorder(t)
		val c = concat(help(pt))
	in
		if isEmpty(t) then TextIO.closeOut(s) else TextIO.output(s,c);
		TextIO.closeOut(s)
	end;

(* Inputs a BST. Returns the smallest value in the tree. If the tree is empty, the
function should return NONE.
Code is from: https://stackoverflow.com/questions/58499619/assistance-working-with-binary-trees-in-sml
 *)
fun getMin leaf = NONE
	| getMin(node(x,leaf,_))=SOME(x)
	| getMin(node(x,left,_)) = getMin(left);

(* Inputs a BST. Returns the largest value in the tree. If the tree is empty, the 
function should return NONE. 
Code was modified from the getMin code to fit for retrieving the max.
Calin did this portion*)
fun getMax leaf = NONE
	| getMax(node(x,_,leaf))=SOME(x)
	| getMax(node(x,_,right)) = getMin(right);

(* Inputs a BST and an integer x. Returns a new tree containing data value x 
inserted correctly. If x is a value already in the tree, then the function will 
return the tree unchanged.  
Code modifed from https://www.cse.iitd.ac.in/~saroj/LFP/LFP_2013/sml4.pdf
*)
fun insert(leaf, i) = node(i,leaf,leaf)
	| insert(node(i2,left,right),i) =
		if i<i2 then node(i2,insert(left,i),right) else node(i2,left,insert(right,i));
	
(* We could not get the Delete portion to work correctly so it is commented out
Code from https://homepages.inf.ed.ac.uk/mfourman/teaching/mlCourse/notes/binary-search-tree.html%5B.htm%5D
Calin worked on this portion after a while we both tried to get it to work and failed
fun join (root,left,x) = x
    | join (root,left,x) = x
    | join (x,left,right) = let val (l,m) = getMax(node(root,left,right)) in node(m,l,right) end;
fun delete (leaf, _) = leaf
    | delete(node(root,left,right), x:int) = 
        if x < root then node(root,delete(node(x,left,right),x),right)
        else if root < x node(root,left,delete(node(x,right,right),x))
        else join (root,left,right)
*)

(* Helper functions that convert the list to different types 
Calin came up with the idea to do this*)
fun help2 [] = nil
	| help2(x::xs) = str(x)::help2(xs); 
fun help3 [] = nil
	| help3(x::xs) = Int.fromString(x)::help3(xs);
(* Helper function that puts the first element in an empty list *)
fun help4 [] = nil
	| help4(x::xs) = x::nil;

(* Inputs a string representing a file name. Returns a BST containing the integers 
contained in the file, which are separated by spaces and read recursively. Uses the
 insert function. Helper functions are also used.*)
fun treeRead(s) =
	let
		val oI = TextIO.openIn(s)
		val ip = TextIO.input(oI)
		val ch = explode(ip)
		val s = help2(ch)
		val i = help3(s)
		val f = help4(i)
		val u = Option.valOf(hd(f))
		val a_tree = leaf
	in
		if length(l)=0 then a_tree else insert(a_tree, u)
		
	end;
