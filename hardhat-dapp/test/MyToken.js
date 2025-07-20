const hre = require("hardhat");

describe("MyToken Test", async () => {
    console.log("等待 2 s");

    beforeEach( async() => {
        await new Promise( (reslove) => {
            setTimeout(() => {
                reslove(1)
            }, 2000)
        })
        console.log("开始运行测试用例");
        
    })
    
    if("test1", async () => {  
        console.log("我是 test1");
    });

    if("test2", async () => {
        console.log("我是 test2");
    });
}) 