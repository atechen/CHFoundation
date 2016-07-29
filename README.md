# CHFoundation

###NSTimer
1. ReleaseTarget：解决NSTimer强引用target，造成target和NSTimer无法释放的两种方案，
使用的时候，还需要在-(void)dealloc{}方法中，调用timer的invalidate()方法
	* HWWeakTimer来源于：[HWWeakTimer开源项目](https://github.com/ChatGame/HWWeakTimer)
	* NSTimer+AFSoundManager来自：[AFSoundManager开源项目](https://github.com/AlvaroFranco/AFSoundManager)
	* NSTimer+CHWeakTimer：模仿写的集成代码