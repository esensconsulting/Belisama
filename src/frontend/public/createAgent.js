import * as ic from "@dfinity/agent";

const createAgent = (host) => {
  const { HttpAgent, IDL, Principal } = ic;
  let keyPair = localStorage.getItem('keypair');
  if(!keyPair) {
    keyPair = ic.generateKeyPair();
    localStorage.setItem('keypair', JSON.stringify(keyPair));
  } else {
    keyPair = JSON.parse(keyPair);
    keyPair = ic.makeKeyPair(new Uint8Array(keyPair.publicKey.data), new Uint8Array(keyPair.secretKey.data));
  }
  console.log(keyPair);
  const agent = new HttpAgent({
    principal: Principal.selfAuthenticating(keyPair.publicKey),
    host,
  });
  agent.addTransform(ic.makeNonceTransform());
  agent.setAuthTransform(ic.makeAuthTransform(keyPair));
  return agent;
};

export default createAgent;