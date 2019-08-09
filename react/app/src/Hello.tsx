import React from 'react';
import hello from './proto/hello_grpc_web_pb';
import {Error} from "grpc-web";

interface State {
    name: string,
    age: number,
}
class Hello extends React.Component<{}, State> {
    public state: State = {
        name: "hoge",
        age: 10,
    }

    public onClick = (ev: React.MouseEvent<HTMLDivElement>): null => {
        const request = new hello.HelloRequest();
        request.setName("hogehoge");
        const metadata = {}

        const client = new hello.HelloServiceClient("https://localhost:8443", {}, {});
        client.hello(request, metadata, (err : Error, ret: any) => {
            if (err || ret === null) {
                throw err;
            }
            this.setState({name: ret.getMessage()});
        });

        return null;
    }

    render() {
        return <h1 onClick={this.onClick}>My name is {this.state.name} {this.state.age} years old.</h1>
    }
}

export default Hello;