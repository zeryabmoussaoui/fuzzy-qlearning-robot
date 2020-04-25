% max(min((X-(a))/((b)-(a)),((c)-X)/((c)-(b))), 0) __a/b\c___

% min(max((X-a)/(b-a),0),1)  % ____(a)/(b)''''''''' 

% max(min((b-X)/(b-a),1),0)  % '''''''(a)\(d)____
function val=trianglar_fct(a,b,c,x,type)
  switch type
      case 'tria'
          val= max(min((x-(a))/((b)-(a)),((c)-x)/((c)-(b))),0);
      case 'end'
          val= min(max((x-a)/(b-a),0),1);
      case 'start'
          val= max(min((b-x)/(b-a),1),0);
end