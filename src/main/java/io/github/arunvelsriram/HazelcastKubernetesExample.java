package io.github.arunvelsriram;

import com.hazelcast.config.ClasspathXmlConfig;
import com.hazelcast.config.Config;
import com.hazelcast.core.Hazelcast;

public class HazelcastKubernetesExample {
    public static void main(String[] args) {
        Config config = new ClasspathXmlConfig("hazelcast.xml");
        Hazelcast.newHazelcastInstance(config);
    }
}