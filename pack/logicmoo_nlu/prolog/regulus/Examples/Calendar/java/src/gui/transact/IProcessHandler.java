package gui.transact;

public interface IProcessHandler {
	void startup() throws Exception;
	boolean shutdown() throws Exception;
}