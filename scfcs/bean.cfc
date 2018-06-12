// generic setter/getter
component
	output="false"
	hint="I store generic private variables." {

    public any function get(string name) 
        hint="I get the given property from the private variables scope." 
    {

        return variables[ arguments.name ];
    }

    public any function set(string name, any value) 
        hint="I store the given value in the private variables scope."
    {

        variables[ arguments.name ] = arguments.value;
        return this;
    }
}
