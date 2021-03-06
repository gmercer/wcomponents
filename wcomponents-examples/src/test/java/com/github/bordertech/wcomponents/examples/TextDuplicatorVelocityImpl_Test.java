package com.github.bordertech.wcomponents.examples;

import com.github.bordertech.wcomponents.Container;
import com.github.bordertech.wcomponents.test.selenium.MultiBrowserRunner;
import com.github.bordertech.wcomponents.test.selenium.driver.SeleniumWComponentsWebDriver;
import junit.framework.Assert;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;
import org.openqa.selenium.By;

/**
 * Selenium unit tests for {@link TextDuplicatorVelocityImpl}.
 *
 * @author Yiannis Paschalidis
 * @since 1.0.0
 */
@Category(SeleniumTests.class)
@RunWith(MultiBrowserRunner.class)
public class TextDuplicatorVelocityImpl_Test extends WComponentExamplesTestCase {

	/**
	 * Creates a TextDuplicator_Test_SeleniumImpl.
	 */
	public TextDuplicatorVelocityImpl_Test() {
		super(new TextDuplicatorVelocityImpl());
	}

	@Test
	public void testDuplicator() {
		// Launch the web browser to the LDE
		SeleniumWComponentsWebDriver driver = getDriver();

		// Enter some text and use the duplicate button
		driver.findWTextField(byWComponent(((Container) getUi()).getChildAt(1))).sendKeys("dummy");
		driver.findElement(By.xpath("//button[text()='Duplicate']")).click();
		Assert.assertEquals("Incorrect text field text after duplicate", "dummydummy",
				driver.findElement(By.xpath("//input[@type='text']")).getAttribute("value"));

		// Clear the text
		driver.findElement(By.xpath("//button[text()='Clear']")).click();
		Assert.assertEquals("Incorrect text field text after clear", "",
				driver.findElement(By.xpath("//input[@type='text']")).getAttribute("value"));
	}
}
